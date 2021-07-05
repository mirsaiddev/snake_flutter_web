'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  ".git/COMMIT_EDITMSG": "afd0405b0080f8ab907bcdce8e89f02f",
".git/config": "6623f6fe716304c8b7a0fd3e635f97ea",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/FETCH_HEAD": "33606499ec44ccbb74126c4d961f5829",
".git/HEAD": "cf7dd3ce51958c5f13fece957cc417fb",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/fsmonitor-watchman.sample": "ea587b0fae70333bce92257152996e70",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-commit.sample": "305eadbbcd6f6d2567e033ad12aabbc4",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/index": "ddf75f38e5cba34640d53c890f59987f",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "05fac9eb35760b96f24e03cca9bfe30f",
".git/logs/refs/heads/main": "77aa249f42a644672591fba4e28920aa",
".git/logs/refs/remotes/origin/main": "894a08a6986f65f3480c804c661a26f2",
".git/objects/03/eaddffb9c0e55fb7b5f9b378d9134d8d75dd37": "87850ce0a3dd72f458581004b58ac0d6",
".git/objects/05/146c3d4207fbfae81f7f5967155d35b02418b6": "139b8251d1442b6d62f1da6ef23a1371",
".git/objects/0a/74823feb9825aa24d5526a03b172d07928b89e": "ff51cdec26aa17a70459072b8fc3a09a",
".git/objects/19/33e3734da3f647cd2efbf4dd89297ec592acf3": "0d23bc91be31a824d5c6418f0f2ee10c",
".git/objects/1f/bd87395836e43f850179c34668fb66215632c5": "aa0cef0e2a9a755a60d2bee24c6f6b07",
".git/objects/20/5bb5db271c6d8de8399864c7bb9b917f638893": "c993b22f115d7f3ae6d5b7b212806539",
".git/objects/27/ca30260a64047c5b1e1577efc520ca7fcac671": "e8bb59db1ff18d19424967b9213969ea",
".git/objects/33/56f0dad981088ec31c6411df0de236479c9d56": "4848b820c5d32688efa01d7343ae6a0c",
".git/objects/35/3fd35ca0d61a707e966cf72fb5dfebb953514d": "d832116fbde0e108535392a5747e4da7",
".git/objects/37/2c9902101acd53a555abb6d66343a11d4718e6": "e35e7a68a30990b39990256433967a7e",
".git/objects/46/21efcd7dd08fffce0c1f07e82e41c7125be31e": "0058b320861a7ec60ad6805098bdad6d",
".git/objects/46/4ab5882a2234c39b1a4dbad5feba0954478155": "2e52a767dc04391de7b4d0beb32e7fc4",
".git/objects/46/985cb1f162d0ee8acc93417eaaecfe13bedcb6": "df028dfda5af790737c7dbbc8546781d",
".git/objects/4b/825dc642cb6eb9a060e54bf8d69288fbee4904": "75589287973d2772c2fc69d664e10822",
".git/objects/4f/98d6c573e1225c85bee987c24d12fb8a4106f6": "1936a05b1077c9fea631fc2d4fa1af35",
".git/objects/57/4bdf45d6542eb01c19b9e01a577553d8612a2e": "115bc5fdef1eb06c6890311c11e82a8a",
".git/objects/57/813e02f33aa42ce3caa104ec6c5462c1e40bdd": "8596ea2f8cda3a3400dda838b98980b0",
".git/objects/58/d12eea1467dfddfab696a00d8ac8a38241e01e": "2ad436f59af01da4016b164aed66bcba",
".git/objects/5f/2dfd9c3424722020d7dce69ab1b8f1f462380c": "003ff0e34cb4d3172c29dec411a1826d",
".git/objects/79/ba7ea0836b93b3f178067bcd0a0945dbc26b3f": "f3e31aec622d6cf63f619aa3a6023103",
".git/objects/82/86f7b322b6d1d1210abe954365b09d018f640a": "c4b8b9cff7645bda8f84bd146c09a957",
".git/objects/82/b4151145c0a0a60408915339bfd317b8e7fde5": "8b4f05cbc7088e70c1e6a1452756cb20",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/8c/90c7fbc5f3031cef644072d9df934d92308cfc": "5a57b7cab3b6c2d95dbd50ed782cd74b",
".git/objects/8d/2062ce737202d605f65a1d64237df06516725c": "f8d1d396e23bc7c70b831b53a7783d1e",
".git/objects/9c/e0de0a5319b14c12fed420c48256413fd9f1b6": "c4037428dfdc6c8bb0972d67a9ba5690",
".git/objects/a0/ea3605050f6a654b5f804d965d7ad6c870ca0e": "fe06e4f32fc5e1a839343937f3d51dd9",
".git/objects/a1/3837a12450aceaa5c8e807c32e781831d67a8f": "bfe4910ea01eb3d69e9520c3b42a0adf",
".git/objects/a5/2514d993837d3e06c3e621a8d6a3e11927b8a8": "e81582561a5901809ab1ca6a113dc5fd",
".git/objects/a8/3a17d54b6dc2156c855c6580301cefc9c8d017": "6525101be8d70b808a809af9c83fa4ad",
".git/objects/ab/0e98497a51ead7821d1da35a24968ff314e50f": "557c35fe3928eb2af403d1b3926bb9ba",
".git/objects/b1/fe335d478f0d2de69bc699be74ff99b4c3990a": "8b37a6fb13428feca2b03cae6015c55e",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/bc/3ad0516f6f073e3097236c1accd52ba63a0c9c": "f64b8db3f80044399abd5d287699d44b",
".git/objects/c4/e57ab3612b865f05a9e7c894d0346ef7c99016": "85392ac6c9fb80841bc652bafe19bc17",
".git/objects/c8/6e14b871cf29f441bf9d070ef02143f9592594": "b178f4533f3bac112c5d2c685e3a6666",
".git/objects/d4/e55dd5f54adb951b7fa50736422b537463f30b": "0d38db451d9f5dd70bf36ff057f8c01b",
".git/objects/db/6788295cedee9fdae78bea71a793a27dce6e88": "55e8cb33162a98a904f5b6c4e12415e2",
".git/objects/dc/9f66a7f4974b6a0cb50df8488f2973dac117a2": "16d7cf2fa590539805da26941c6b76c6",
".git/objects/de/25281f4488bb3962aac5a2f0efe940b0f26775": "2e8b95100d41ac256b9aeee5f3fe7e6c",
".git/objects/e5/951dfb943474a56e611d9923405cd06c2dd28d": "c6fa51103d8db5478e1a43a661f6c68d",
".git/objects/ec/89a700bb0eb918cbb198887234cf2f91728a12": "6fb8d989d0f21e06c80950923389377c",
".git/objects/f2/5787c93ad00665f0f797a43ab397f0628a273e": "59e425d1456034072d902c75d18ec75f",
".git/objects/f6/07d82307183a97ab6d0c17d3c42857012149e0": "2b16ae57f665beacb584634baf6b2bfd",
".git/objects/f6/52fae612b35a4d428b55a48d1293f93481cad4": "c05795bcc606485d8dc7d210037c3673",
".git/objects/f8/aeed64fe06af49ffcac37512b635ff74bea6ac": "f75dcd5ded2cc798a222db849c9fba80",
".git/objects/fb/f1cefd35d1511e4d5946151ba3a6d9a68eb480": "30ec955775cb10c12d7f51c329460e50",
".git/ORIG_HEAD": "eabd2737e9329f385227715cf4e9bc58",
".git/refs/heads/main": "05e1e12af11d59735dfe6a0b08972c49",
".git/refs/remotes/origin/main": "05e1e12af11d59735dfe6a0b08972c49",
"assets/AssetManifest.json": "2efbb41d7877d10aac9d091f58ccd7b9",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "1288c9e28052e028aba623321f7826ac",
"assets/NOTICES": "a7ca66253ed4752434ec98927f9c1485",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"index.html": "55fcfde6315d76509011da5945288e80",
"/": "55fcfde6315d76509011da5945288e80",
"main.dart.js": "8b32418bd3af27ab1c8691d3a360c646",
"manifest.json": "92b981e5821151c62f5e75fdb666ae5f",
"version.json": "39f479bd9a84277838ad58e5ecb4fbaf"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value + '?revision=' + RESOURCES[value], {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
