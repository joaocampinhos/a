var app = angular.module("spacialAnalysis");

app.factory("Map", function(ContextService, $rootScope) {
  var Map;
  return Map = (function() {
    var drawCircle, drawDot, updateContext;

    function Map(id, canvas_width, canvas_height) {
      this.canvas_width = canvas_width;
      this.canvas_height = canvas_height;
      this.bounds = L.latLngBounds([]);
      this.map = L.map(id);
      this.map.setView([51.505, -0.09], 13);
      L.tileLayer("http://{s}.tile.osm.org/{z}/{x}/{y}.png", {
        attribution: "&copy; <a href=\"http://osm.org/copyright\">OpenStreetMap</a> contributors"
      }).addTo(this.map);
      this.current_layer = new L.TileLayer.Canvas();
      this.map.addLayer(this.current_layer);
      this.map.on("dragend", function() {
        var map;
        console.log("draged");
        map = this;
        return $rootScope.$apply(function() {
          return updateContext(map);
        });
      });
      this.map.on("zoomend", function() {
        var map;
        map = this;
        return $rootScope.$apply(function() {
          return updateContext(map);
        });
      });
    }

    Map.prototype.drawDotLayer = function(points, pixelResolution) {
      if (pixelResolution == null) {
        pixelResolution = 0;
      }
      this.bounds = L.latLngBounds([]);
      this.map.removeLayer(this.current_layer);
      this.current_layer = new L.TileLayer.Canvas();
      this.current_layer.drawTile = (function(_this) {
        return function(canvas, tile, zoom) {
          var context, image, tileSize;
          tileSize = _this.current_layer.options.tileSize;
          context = canvas.getContext("2d");
          image = context.createImageData(1, 1);
          return _.each(points, function(point) {
            var gpsCoords, start, x, y;
            start = tile.multiplyBy(tileSize);
            gpsCoords = new L.LatLng(point.latitude, point.longitude);
            point = _this.map.project(gpsCoords);
            x = point.x - start.x;
            y = point.y - start.y;
            if (parseFloat(pixelResolution) === 0) {
              drawDot(x, y, image, context);
            } else {
              drawCircle(x, y, parseFloat(pixelResolution), context);
            }
            return _this.bounds.extend(gpsCoords);
          });
        };
      })(this);
      return this.map.addLayer(this.current_layer);
    };

    Map.prototype.fitToBounds = function() {
      this.map.fitBounds(this.bounds);
      return updateContext(this.map);
    };

    drawDot = function(x, y, image, context) {
      var d;
      d = image.data;
      d[0] = 255;
      d[1] = 0;
      d[2] = 0;
      d[3] = 255;
      return context.putImageData(image, x, y);
    };

    drawCircle = function(x, y, radius, context) {
      context.beginPath();
      context.arc(x, y, radius, 0, Math.PI * 2, false);
      context.fillStyle = "red";
      context.closePath();
      return context.fill();
    };

    updateContext = function(map) {
      var bottomLeft, bounds, topRight;
      bounds = map.getBounds();
      bottomLeft = bounds.getSouthWest();
      topRight = bounds.getNorthEast();
      ContextService.map.zoom = map.getZoom();
      ContextService.map.center = {
        latitude: map.getCenter().lat,
        longitude: map.getCenter().lng
      };
      ContextService.map.bounds.bottomLeft = {
        latitude: bottomLeft.lat,
        longitude: bottomLeft.lng
      };
      ContextService.map.bounds.topRight = {
        latitude: topRight.lat,
        longitude: topRight.lng
      };
      return ContextService.map.view.origin = map.getPixelOrigin();
    };

    return Map;

  })();
});

