Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752165AbeBCKuh (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 05:50:37 -0500
Received: from mout.web.de ([212.227.17.12]:62445 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750765AbeBCKu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 05:50:29 -0500
To: linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Stefan Achatz <erazor_de@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] HID: Roccat: Delete an error message for a failed memory
 allocation in nine functions
Message-ID: <5df2ad06-296d-7552-d36d-dd8b09ad6f6d@users.sourceforge.net>
Date: Sat, 3 Feb 2018 11:50:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:R7bbOLzkUjFUcQM8p2DPzoITUeS+3YF4qnTcmP3URDrpwDC7vfx
 m/mFZlp38aw3MEGe5/xRJ7uYcjovyuCfbbDRsAET4CdGXe4MLtnOmfVQGj2vxy0RHX3hSq6
 U6dZ7KWA0H5WVOeeJW/b9DU2fnnH7GRMlRSNhpgWqA2v1708bpAEllyxYRNDzNyOhD8cAl8
 D/lpdCcyrB1iSCLTDh4Bw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Tc83A2nmIy8=:mfam44hm432kOFUfMoGvWo
 hG0VfWEasus9bJdC0ghBnxbeQatQ1LMMR9f3sG69JDIA9oiD0PbupaQx5vrl+8/D86+e5riY2
 tKhsPY5HgMtC7keqAk6IrFsGvm6G1BM5YFhjh5zMaW5tS9BDMEhx/etsIpQ31MPW6x8d2DIgB
 XEFf7g+iWfojxGVv5SNYBLz3GtYApew74y92rW5gYkaWvNHHhZtruQVUU4GgB2YDJ116VU8hZ
 TrxeCXUpUzMvHc+zsshQO4e0wYsWfPpMip5HN6ZnpBaOOKk0yp5hYBqKuLcv9lHJErCgk174v
 +t7+2PV2d2WbBvc4UfOiaGTMbAovM8xSM8dJghtou8U84/zLPVn4vIWhGYeYKPdJAWfGqjlCa
 ZpuAlyp5Ply+gjnHzIukx32zW5cS3Pph5SkKEdKEY52ZjHtNjrXHLKrQVY5kua0SCP7djxBw6
 nsFKeowryLgWOnwfAcoosJi/jx3wtgCPEhXH4ThJm65duTvQpz34kQl/qOFBBevMGPDg7qT46
 e1enbCuZJr6pj1VOXiqlEyIW2nSf/82vo2PPrqxZb28Eu0dEB6X7NkJR5e9hTV7BeR40OEPPZ
 /6HAvOEMjG6xzMz9fqyY7+J8eN1FQYSxpvdUMxYsHgX0fezm9Yi/ey5z8nCMqu5e9vdQ1PHDJ
 yGiPVkax3/4qNXr5WhqLD1HZUpvsUYE/zvishlFGwEk1zrxd9uY4jKLEX3EmPULwPUEvpj+H5
 x3N7MK1wunF7IF6RviX6eyMAoRGzg6REi+o2x1hCwu3So9qRH/j3eUoQTAyyPoxrseUusbaEn
 /uy1ffM9HwRUcuh1TLji9mUjgL+gSTa5TvDs+skkPqxvKh6ETw=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 3 Feb 2018 11:45:15 +0100

Omit an extra message for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-roccat-arvo.c     | 5 ++---
 drivers/hid/hid-roccat-isku.c     | 5 ++---
 drivers/hid/hid-roccat-koneplus.c | 5 ++---
 drivers/hid/hid-roccat-konepure.c | 5 ++---
 drivers/hid/hid-roccat-kovaplus.c | 5 ++---
 drivers/hid/hid-roccat-lua.c      | 5 ++---
 drivers/hid/hid-roccat-pyra.c     | 5 ++---
 drivers/hid/hid-roccat-ryos.c     | 5 ++---
 drivers/hid/hid-roccat-savu.c     | 5 ++---
 9 files changed, 18 insertions(+), 27 deletions(-)

diff --git a/drivers/hid/hid-roccat-arvo.c b/drivers/hid/hid-roccat-arvo.c
index 329c5d1270f9..8d1eccd4fffd 100644
--- a/drivers/hid/hid-roccat-arvo.c
+++ b/drivers/hid/hid-roccat-arvo.c
@@ -300,10 +300,9 @@ static int arvo_init_specials(struct hid_device *hdev)
 	}
 
 	arvo = kzalloc(sizeof(*arvo), GFP_KERNEL);
-	if (!arvo) {
-		hid_err(hdev, "can't alloc device descriptor\n");
+	if (!arvo)
 		return -ENOMEM;
-	}
+
 	hid_set_drvdata(hdev, arvo);
 
 	retval = arvo_init_arvo_device_struct(usb_dev, arvo);
diff --git a/drivers/hid/hid-roccat-isku.c b/drivers/hid/hid-roccat-isku.c
index 02db537f8f3e..6f18925c72db 100644
--- a/drivers/hid/hid-roccat-isku.c
+++ b/drivers/hid/hid-roccat-isku.c
@@ -280,10 +280,9 @@ static int isku_init_specials(struct hid_device *hdev)
 	}
 
 	isku = kzalloc(sizeof(*isku), GFP_KERNEL);
-	if (!isku) {
-		hid_err(hdev, "can't alloc device descriptor\n");
+	if (!isku)
 		return -ENOMEM;
-	}
+
 	hid_set_drvdata(hdev, isku);
 
 	retval = isku_init_isku_device_struct(usb_dev, isku);
diff --git a/drivers/hid/hid-roccat-koneplus.c b/drivers/hid/hid-roccat-koneplus.c
index 09e8fc72aa1d..3981553d02a6 100644
--- a/drivers/hid/hid-roccat-koneplus.c
+++ b/drivers/hid/hid-roccat-koneplus.c
@@ -385,10 +385,9 @@ static int koneplus_init_specials(struct hid_device *hdev)
 			== USB_INTERFACE_PROTOCOL_MOUSE) {
 
 		koneplus = kzalloc(sizeof(*koneplus), GFP_KERNEL);
-		if (!koneplus) {
-			hid_err(hdev, "can't alloc device descriptor\n");
+		if (!koneplus)
 			return -ENOMEM;
-		}
+
 		hid_set_drvdata(hdev, koneplus);
 
 		retval = koneplus_init_koneplus_device_struct(usb_dev, koneplus);
diff --git a/drivers/hid/hid-roccat-konepure.c b/drivers/hid/hid-roccat-konepure.c
index 07de2f9014c6..529e6024e73f 100644
--- a/drivers/hid/hid-roccat-konepure.c
+++ b/drivers/hid/hid-roccat-konepure.c
@@ -89,10 +89,9 @@ static int konepure_init_specials(struct hid_device *hdev)
 	}
 
 	konepure = kzalloc(sizeof(*konepure), GFP_KERNEL);
-	if (!konepure) {
-		hid_err(hdev, "can't alloc device descriptor\n");
+	if (!konepure)
 		return -ENOMEM;
-	}
+
 	hid_set_drvdata(hdev, konepure);
 
 	retval = roccat_common2_device_init_struct(usb_dev, konepure);
diff --git a/drivers/hid/hid-roccat-kovaplus.c b/drivers/hid/hid-roccat-kovaplus.c
index 43617fb28b87..da9c090542c6 100644
--- a/drivers/hid/hid-roccat-kovaplus.c
+++ b/drivers/hid/hid-roccat-kovaplus.c
@@ -452,10 +452,9 @@ static int kovaplus_init_specials(struct hid_device *hdev)
 			== USB_INTERFACE_PROTOCOL_MOUSE) {
 
 		kovaplus = kzalloc(sizeof(*kovaplus), GFP_KERNEL);
-		if (!kovaplus) {
-			hid_err(hdev, "can't alloc device descriptor\n");
+		if (!kovaplus)
 			return -ENOMEM;
-		}
+
 		hid_set_drvdata(hdev, kovaplus);
 
 		retval = kovaplus_init_kovaplus_device_struct(usb_dev, kovaplus);
diff --git a/drivers/hid/hid-roccat-lua.c b/drivers/hid/hid-roccat-lua.c
index ac1a7313e259..0ccaa345de27 100644
--- a/drivers/hid/hid-roccat-lua.c
+++ b/drivers/hid/hid-roccat-lua.c
@@ -123,10 +123,9 @@ static int lua_init_specials(struct hid_device *hdev)
 	int retval;
 
 	lua = kzalloc(sizeof(*lua), GFP_KERNEL);
-	if (!lua) {
-		hid_err(hdev, "can't alloc device descriptor\n");
+	if (!lua)
 		return -ENOMEM;
-	}
+
 	hid_set_drvdata(hdev, lua);
 
 	retval = lua_init_lua_device_struct(usb_dev, lua);
diff --git a/drivers/hid/hid-roccat-pyra.c b/drivers/hid/hid-roccat-pyra.c
index b30aa7b82bf8..c22cc42dadb6 100644
--- a/drivers/hid/hid-roccat-pyra.c
+++ b/drivers/hid/hid-roccat-pyra.c
@@ -404,10 +404,9 @@ static int pyra_init_specials(struct hid_device *hdev)
 			== USB_INTERFACE_PROTOCOL_MOUSE) {
 
 		pyra = kzalloc(sizeof(*pyra), GFP_KERNEL);
-		if (!pyra) {
-			hid_err(hdev, "can't alloc device descriptor\n");
+		if (!pyra)
 			return -ENOMEM;
-		}
+
 		hid_set_drvdata(hdev, pyra);
 
 		retval = pyra_init_pyra_device_struct(usb_dev, pyra);
diff --git a/drivers/hid/hid-roccat-ryos.c b/drivers/hid/hid-roccat-ryos.c
index 47cc8f30ff6d..1153e07ae415 100644
--- a/drivers/hid/hid-roccat-ryos.c
+++ b/drivers/hid/hid-roccat-ryos.c
@@ -97,10 +97,9 @@ static int ryos_init_specials(struct hid_device *hdev)
 	}
 
 	ryos = kzalloc(sizeof(*ryos), GFP_KERNEL);
-	if (!ryos) {
-		hid_err(hdev, "can't alloc device descriptor\n");
+	if (!ryos)
 		return -ENOMEM;
-	}
+
 	hid_set_drvdata(hdev, ryos);
 
 	retval = roccat_common2_device_init_struct(usb_dev, ryos);
diff --git a/drivers/hid/hid-roccat-savu.c b/drivers/hid/hid-roccat-savu.c
index 6dbf6e04dce7..3b39f6556708 100644
--- a/drivers/hid/hid-roccat-savu.c
+++ b/drivers/hid/hid-roccat-savu.c
@@ -69,10 +69,9 @@ static int savu_init_specials(struct hid_device *hdev)
 	}
 
 	savu = kzalloc(sizeof(*savu), GFP_KERNEL);
-	if (!savu) {
-		hid_err(hdev, "can't alloc device descriptor\n");
+	if (!savu)
 		return -ENOMEM;
-	}
+
 	hid_set_drvdata(hdev, savu);
 
 	retval = roccat_common2_device_init_struct(usb_dev, savu);
-- 
2.16.1
