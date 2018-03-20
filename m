Return-Path: <outreachy-kernel+bncBCUKTKFB3EKRBONGYXKQKGQECZZCPGI@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1521570617; cv=pass;
        d=google.com; s=arc-20160816;
        b=fZLllltpxo8KJv/4tglxXXqzSaOOIHf7B9ev25FxmGlJHXFVsWeIayMWuySyP0NKJa
         NzQv6hbKZQNEZH2iKLL7WfYXVRyXcPO5s62+w/PcBPZDx1bSGXFTSZjdRBALwP3p/Ghn
         LfCrVBR2oo2T5letwNY2Apa10JEOsAVCSn7axW49o7DQOSZCXzxc/svE1UiO9q4Ig9Qr
         pgsF+EjT/DZRlRa6cO7WKJkhnUDqNOyT8osztRAeKMufhPy5eI1iF9H3gQod2eE0LuIG
         KcOxKm2RHfDGBm66MVppD2uDaTQUEP7CymanT7VsG1E0u9GtbPFJD+74FNL5LNeZNuWh
         RrEQ==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:message-id:date:subject:cc:to:from
         :arc-authentication-results:arc-message-signature:mime-version
         :sender:dkim-signature:dkim-signature:arc-authentication-results
         :arc-message-signature:arc-authentication-results;
        bh=mQeCxD+V5ScCvRV7yLNxEJvyFEY3XQnWPvzlY05XTbk=;
        b=S8X4p9hXm807iq/XPzH0TxDc/9eocybb+LIqxaEWfiYgI3Q8PrmVrEQKzUAiqkAUlX
         u0MBzboj6ciWeFtq3tPaZnfxsUkqa172dzx8felF0DMwSCuYuW8xwD9zkWRrhqPVW3as
         YCBs0AMvTuIIT1bPrfRBs+Ou/de7hoq4hi6rO4Bha4bpb89AXVXYvvPVwfaGZ25KkuUc
         GDCAkHctPfTPDKShYAsr6p+3rkplwYv1j0CKgtw8PyEgpJ4R+BvnfJkHWqs5ivGa5tpg
         j5QkPqeoTU+JVGbtJvCKvJmdAxaBK+ED5R779E8Adkwh65Rq9DqaofnkQ8SJOZaOokbN
         QxwQ==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=r50U+UYB;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=O10xHnbd;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbcuktkfb3ekrbongyxkqkgqeczzcpgi@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCUKTKFB3EKRBONGYXKQKGQECZZCPGI@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=r50U+UYB;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=O10xHnbd;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbcuktkfb3ekrbongyxkqkgqeczzcpgi@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCUKTKFB3EKRBONGYXKQKGQECZZCPGI@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
ARC-Seal: i=2; a=rsa-sha256; t=1521570617; cv=pass;
        d=google.com; s=arc-20160816;
        b=pcpxZIKRXqVu4x832hT+3RVN1gCc0Z3dqMbYgL3+O+YapxFOxrCDcXLpK32idRGvNG
         OTgXns7z43xxwirFBLSQ7fU5+ITic+9orfh6sccBWiKjqHRWXgfhJ3E+lzX7gB9P9ugJ
         oZIroSoBtJL2GX5dIG8R/J9RyWlcCEMjq+Jy2oxAK5DOPkFwANQrtFFFGdwjl0n8aN8E
         df39L3utaerG53SLOz0r82AQu8UQLpgoO4cLGO64CmtTSVm2DWjVwZoWOwkDoyKSGYiF
         m4pr+AbXCN0MNKQAM8FI9jcSLmModfqZmBOeTJfQtUmujVVPJlfB1I/pWqXEu9yAn/Wn
         9KaQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:message-id:date:subject:cc:to:from
         :arc-authentication-results:arc-message-signature:mime-version
         :sender:dkim-signature:dkim-signature:arc-authentication-results;
        bh=mQeCxD+V5ScCvRV7yLNxEJvyFEY3XQnWPvzlY05XTbk=;
        b=XUN/aZsFYsIFsVDsZx90BpaEkee9WKvQUIPUd4zOjOCid2l1IYLGkfnNJ4lhN2WMGY
         o9v28cHNqkj8TYZ5qxUvu9qP7Zc6CTYDIv1qdQrGOwyshTWdIHAi7hh89o+eipVyH1Yf
         d5A5k/0oJVzMkPgLA+5ujg1B1/2/kEgKVWDGMtivMzp85QwvRY0yjkg0gt+NJTo6/5rc
         F3/ZYSOhgwV0eqyTDFNuiFBosr171z7+rMWGgsgAQlN6yIazllvaTH7OESTtjXy4+xiA
         xyhEwkWgFisJa8tNYyG9K6TDbDzyLFNyod+TjUyOK72vkZYQQTNiiqpSxDo/JgkQaWg0
         wn5w==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=SeJFOjnZ;
       spf=pass (google.com: domain of santhameena13@gmail.com designates 2607:f8b0:400e:c01::229 as permitted sender) smtp.mailfrom=santhameena13@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AG47ELu6tnldukJni62L32EY1Apff4bxxAwxk3V9pmcm9ZsIsAxyv24RILIWALv1UBMabBFQ5BO6hQ==
MIME-Version: 1.0
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1521570616; cv=none;
        d=google.com; s=arc-20160816;
        b=ISo2EEvSmbvjH6SjV1SAyqG1YBGFAFWmPVKf7WOhocFWB9UxEtWA9sKDiorNNIywA9
         A1UJUUg6EtLY1m3MNMwqSAk4cs6AZ/SeObbd/PyafvfanRGgQ/j7bq3vnmkrHTwvPxDn
         cF6YLMZhoaFu3zZ76Tixe3Mott3RCXNwAcA0rQY9HSrXT2mh+8gjDFJJ8byUbU/VtJkz
         nBPrEjoClpOYSI2t/jNXrzYNWOxENJ5VA4kmnTC4iEL+7gRnLIQz1GAm9O/oCYjtv2UV
         ciH0Txa56KuG/UVj+ZPk6lWSQeyDEnr9Vs/4ZEEmRI6lGguS4yHas8adv7gw2OHygIRD
         O7Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=eU1RCaUM8gT3Qi1alTTjoD/aPi8L66QRRMGja44Ag3k=;
        b=ULGKKObOIArtfHUtbEOru+nUsCXt4TzFTZRTJ9bu7ne6JNbv07Br3A9FodzXWZgNSz
         SU1psoNaBzOPoV6iH+O7XaTa3H/8FZRwm8Ns2mdm9W2cZ2aqJHRaZli8hLZGhOPIs3ul
         sk0rVO+UKutmOtOVjE2WWcGwAXNrGryQFXOORMWZ00fqSwUldePEh+EcYKZCSJDpR8/4
         +wirusokIYBMsm5caicsFci90krnJaTOfnEyXFeUSK6GJNe6BTgCLN7+WC2jLje9Xjtz
         rjI8kIFxlB2RI0OgaUQS/ORbC3MHC6jBMOFXYhE3/phHnCEOGoaQB0pqCkVtnIrHHOWM
         Q+Mw==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=SeJFOjnZ;
       spf=pass (google.com: domain of santhameena13@gmail.com designates 2607:f8b0:400e:c01::229 as permitted sender) smtp.mailfrom=santhameena13@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
From: Santha Meena Ramamoorthy <santhameena13@gmail.com>
To: airlied@redhat.com
Cc: kraxel@redhat.com,
	airlied@linux.ie,
	virtualization@lists.linux-foundation.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	outreachy-kernel@googlegroups.com,
	seanpaul@chromium.org,
	daniel.vetter@intel.com,
	Santha Meena Ramamoorthy <santhameena13@gmail.com>
Subject: [Outreachy kernel] [PATCH] drm/qxl: Replace drm_gem_object_reference/unreference()
 with _get/put()
Date: Tue, 20 Mar 2018 11:29:27 -0700
Message-Id: <1521570567-22519-1-git-send-email-santhameena13@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Original-Sender: santhameena13@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       dkim=pass
 header.i=@gmail.com header.s=20161025 header.b=SeJFOjnZ;       spf=pass
 (google.com: domain of santhameena13@gmail.com designates 2607:f8b0:400e:c01::229
 as permitted sender) smtp.mailfrom=santhameena13@gmail.com;       dmarc=pass
 (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Content-Type: text/plain; charset="UTF-8"
Mailing-list: list outreachy-kernel@googlegroups.com; contact outreachy-kernel+owners@googlegroups.com
X-Spam-Checked-In-Group: outreachy-kernel@googlegroups.com
X-Google-Group-Id: 672804067692
List-Post: <https://groups.google.com/group/outreachy-kernel/post>, <mailto:outreachy-kernel@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:outreachy-kernel+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/outreachy-kernel
List-Unsubscribe: <mailto:googlegroups-manage+672804067692+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/outreachy-kernel/subscribe>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595482431750972321?=
X-GMAIL-MSGID: =?utf-8?q?1595482431750972321?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Replace drm_gem_object_reference/unreference function with *_get/put()
suffixes, because it is shorter and consistent with the kernel
kref_get/put() functions. The following Coccinelle script was used:

@@
expression e;
@@

(
-drm_gem_object_reference(e);
+drm_gem_object_get(e);
|
-drm_gem_object_unreference(e);
+drm_gem_object_put(e);
|
-drm_gem_object_unreference_unlocked(e);
+drm_gem_object_put_unlocked(e);
)

Signed-off-by: Santha Meena Ramamoorthy <santhameena13@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 4 ++--
 drivers/gpu/drm/qxl/qxl_dumb.c    | 2 +-
 drivers/gpu/drm/qxl/qxl_fb.c      | 6 +++---
 drivers/gpu/drm/qxl/qxl_gem.c     | 2 +-
 drivers/gpu/drm/qxl/qxl_ioctl.c   | 4 ++--
 drivers/gpu/drm/qxl/qxl_object.c  | 6 +++---
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 9a9214a..ecb35ed 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -309,7 +309,7 @@ void qxl_user_framebuffer_destroy(struct drm_framebuffer *fb)
 	struct qxl_bo *bo = gem_to_qxl_bo(qxl_fb->obj);
 
 	WARN_ON(bo->shadow);
-	drm_gem_object_unreference_unlocked(qxl_fb->obj);
+	drm_gem_object_put_unlocked(qxl_fb->obj);
 	drm_framebuffer_cleanup(fb);
 	kfree(qxl_fb);
 }
@@ -1215,7 +1215,7 @@ qxl_user_framebuffer_create(struct drm_device *dev,
 	ret = qxl_framebuffer_init(dev, qxl_fb, mode_cmd, obj, &qxl_fb_funcs);
 	if (ret) {
 		kfree(qxl_fb);
-		drm_gem_object_unreference_unlocked(obj);
+		drm_gem_object_put_unlocked(obj);
 		return NULL;
 	}
 
diff --git a/drivers/gpu/drm/qxl/qxl_dumb.c b/drivers/gpu/drm/qxl/qxl_dumb.c
index 11085ab..c666b89 100644
--- a/drivers/gpu/drm/qxl/qxl_dumb.c
+++ b/drivers/gpu/drm/qxl/qxl_dumb.c
@@ -82,6 +82,6 @@ int qxl_mode_dumb_mmap(struct drm_file *file_priv,
 		return -ENOENT;
 	qobj = gem_to_qxl_bo(gobj);
 	*offset_p = qxl_bo_mmap_offset(qobj);
-	drm_gem_object_unreference_unlocked(gobj);
+	drm_gem_object_put_unlocked(gobj);
 	return 0;
 }
diff --git a/drivers/gpu/drm/qxl/qxl_fb.c b/drivers/gpu/drm/qxl/qxl_fb.c
index 23af3e3..3388914 100644
--- a/drivers/gpu/drm/qxl/qxl_fb.c
+++ b/drivers/gpu/drm/qxl/qxl_fb.c
@@ -95,7 +95,7 @@ static void qxlfb_destroy_pinned_object(struct drm_gem_object *gobj)
 	qxl_bo_kunmap(qbo);
 	qxl_bo_unpin(qbo);
 
-	drm_gem_object_unreference_unlocked(gobj);
+	drm_gem_object_put_unlocked(gobj);
 }
 
 int qxl_get_handle_for_primary_fb(struct qxl_device *qdev,
@@ -316,11 +316,11 @@ static int qxlfb_create(struct qxl_fbdev *qfbdev,
 		qxl_bo_unpin(qbo);
 	}
 	if (fb && ret) {
-		drm_gem_object_unreference_unlocked(gobj);
+		drm_gem_object_put_unlocked(gobj);
 		drm_framebuffer_cleanup(fb);
 		kfree(fb);
 	}
-	drm_gem_object_unreference_unlocked(gobj);
+	drm_gem_object_put_unlocked(gobj);
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/qxl/qxl_gem.c b/drivers/gpu/drm/qxl/qxl_gem.c
index 85f5467..f5c1e78 100644
--- a/drivers/gpu/drm/qxl/qxl_gem.c
+++ b/drivers/gpu/drm/qxl/qxl_gem.c
@@ -98,7 +98,7 @@ int qxl_gem_object_create_with_handle(struct qxl_device *qdev,
 		return r;
 	/* drop reference from allocate - handle holds it now */
 	*qobj = gem_to_qxl_bo(gobj);
-	drm_gem_object_unreference_unlocked(gobj);
+	drm_gem_object_put_unlocked(gobj);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c b/drivers/gpu/drm/qxl/qxl_ioctl.c
index e8c0b10..e238a1a 100644
--- a/drivers/gpu/drm/qxl/qxl_ioctl.c
+++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
@@ -121,7 +121,7 @@ static int qxlhw_handle_to_bo(struct drm_file *file_priv, uint64_t handle,
 	qobj = gem_to_qxl_bo(gobj);
 
 	ret = qxl_release_list_add(release, qobj);
-	drm_gem_object_unreference_unlocked(gobj);
+	drm_gem_object_put_unlocked(gobj);
 	if (ret)
 		return ret;
 
@@ -343,7 +343,7 @@ static int qxl_update_area_ioctl(struct drm_device *dev, void *data,
 	qxl_bo_unreserve(qobj);
 
 out:
-	drm_gem_object_unreference_unlocked(gobj);
+	drm_gem_object_put_unlocked(gobj);
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/qxl/qxl_object.c b/drivers/gpu/drm/qxl/qxl_object.c
index f6b80fe..e9fb0ab 100644
--- a/drivers/gpu/drm/qxl/qxl_object.c
+++ b/drivers/gpu/drm/qxl/qxl_object.c
@@ -211,13 +211,13 @@ void qxl_bo_unref(struct qxl_bo **bo)
 	if ((*bo) == NULL)
 		return;
 
-	drm_gem_object_unreference_unlocked(&(*bo)->gem_base);
+	drm_gem_object_put_unlocked(&(*bo)->gem_base);
 	*bo = NULL;
 }
 
 struct qxl_bo *qxl_bo_ref(struct qxl_bo *bo)
 {
-	drm_gem_object_reference(&bo->gem_base);
+	drm_gem_object_get(&bo->gem_base);
 	return bo;
 }
 
@@ -318,7 +318,7 @@ void qxl_bo_force_delete(struct qxl_device *qdev)
 		list_del_init(&bo->list);
 		mutex_unlock(&qdev->gem.mutex);
 		/* this should unref the ttm bo */
-		drm_gem_object_unreference_unlocked(&bo->gem_base);
+		drm_gem_object_put_unlocked(&bo->gem_base);
 	}
 }
 
-- 
2.7.4

-- 
You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/1521570567-22519-1-git-send-email-santhameena13%40gmail.com.
For more options, visit https://groups.google.com/d/optout.
