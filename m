Return-Path: <outreachy-kernel+bncBCAMTT4T6ABRB6F6XPKQKGQE6W74YGY@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1521409913; cv=pass;
        d=google.com; s=arc-20160816;
        b=PsyRn7jCfjelXaY66+wXUt1LTUFn2l4dQzumt5/5HM9cMO9E0ltrABFrix+vAFyybZ
         7RUqc4IXQCBa9Z1pFhkyFcW/1ibVOCMlYn11T8xyQkLW195iYbihBrcNLfxE6+IrAofp
         NG4dPe6DMyGk97qzET/WpU2ZH5nWiEb7GEEsP3NX5KCtQADoeQ+c4wPP130cloXq/akj
         zbAE/8LGlPuzT+uD0fMbOhPJ3krVC4QtWKRLzKEmivrO7stSICESaiZpx7tNQKPMpUJV
         EQNwMvVRf0Ghlxdd/LPJy45i1twbiSWYxq0HZ6SHgzJMAvWVNKGNrVPbMzFs3ZwwDkQ7
         rmbg==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:user-agent:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:arc-authentication-results
         :arc-message-signature:sender:dkim-signature:dkim-signature
         :arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=4dGqnKdr7NN3Z1Jrlr9vzBkxjTJHLaeTtX//tA8aIYs=;
        b=V5KbMwKyfjeiOp6/gRgFSw/pSw9nKTyj5XBZcRugNG9Y0ECipYaIxlSqmn8JFAr5jZ
         hwIz9Ehmc/O3oIh94Ht2FQIhu+uFYDKpmK8IbZOeZ2KWGZxvUqO4o1qUqDmUIePpdjM3
         HLi8tIGzojPbEm2cX+0zkTgTOgEyU3fTAjtSgG9qAv4RUGheI0QgRptw7OxeP7ERTMtV
         hVxeCynsvDNnIlZFa47miDmaERvU76IQiN5nIlj+muRe0z52XW8mP4eviTyKw+CpUuIJ
         zmGA+Myb1/CO/25G3vjx7hPMHtC+Rze3OnBOwPSS87TP0Qpg7SF18JI3+Qod7GVecpGD
         5PbA==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=hS0emlwn;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=cuthqMIm;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbcamtt4t6abrb6f6xpkqkgqe6w74ygy@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCAMTT4T6ABRB6F6XPKQKGQE6W74YGY@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=hS0emlwn;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=cuthqMIm;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbcamtt4t6abrb6f6xpkqkgqe6w74ygy@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCAMTT4T6ABRB6F6XPKQKGQE6W74YGY@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
ARC-Seal: i=2; a=rsa-sha256; t=1521409913; cv=pass;
        d=google.com; s=arc-20160816;
        b=oDZZdFz/RTpGAzQ2nCCgcIhEqqSihqxAKe+A2CWV6pkh2Fc0Xp6MFG63bLPonuYOaP
         1+IP1YqwsvP2dhmfZtCflfRgq4lB7m0tWQnr+pZWXTDTvRxtv74aDctStLAKEi32JMlJ
         EkxyUp7HB/f6yVMdIxmBOraBtM2QsbI6D/PxrVFPf6y3j1MaqXeVnMX1kluWjOFpJxin
         WE1UKBbPjYLOqHmLogLbx0WV2P7ZN/al/75U3MBCglLev8C23uW7PR3jM8FXNDhk4ZYU
         y/QZoRLT/M8Mix7Fwq9fguoz9/x6AzWMwuVMGayDTE2dfiLjCdaCFCcSfbnaGBYHijuz
         1DaA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:user-agent:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:arc-authentication-results
         :arc-message-signature:sender:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=4dGqnKdr7NN3Z1Jrlr9vzBkxjTJHLaeTtX//tA8aIYs=;
        b=07Ybk7+OgkgWFUiCjb/msZNX2WZNkV58TVNgfBc6Ia/liXQ30cbgVeC6K8uyP2/0Sz
         J5/r5kTAGrZmZQQ3YIq6HfDSeQeHbqgb5uIlHeVLrxanXTvT15OByNGQ8ISSJsViqePw
         fKR2KvI2JXmLk8Q6PUvrNAr451ncAlBeBxHsNbSm8AYipHcoVm5mpYcsAk9FFGauv9bp
         eCy3boci3nJI0OaukXRSmtO9lHrDxnW+TSo6FXngvrZweMd1dhw/xvD14xSjGmMup2Yz
         W8euFWezSRjSkjkNmpMk/S2wuwA7ixKxdAo9fEqrUhqsunTPYlEKFocEQyZGDy91BLgW
         1g2Q==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=nkKt+6p3;
       spf=pass (google.com: domain of arushisinghal19971997@gmail.com designates 2607:f8b0:400e:c00::243 as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AG47ELvX55X4ds+s6jojnHevzM1SDcqEBLmjL6lb5F6HXqW1iwVZixGzEiE2JsTUcl5MJ6Iz3zuRcw==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1521409912; cv=none;
        d=google.com; s=arc-20160816;
        b=g8epOqApP9tSLOZurrE142oWS0pU8yhg7my3NICWPGLt8nJpzFgo3ZxGvyfana9raW
         nblsj8bt7GWodmL8s+MeOP0At9SGKI/sAAACtAJ87HJkJ6U3esZL0k6Jz2FUxdp9N0Ac
         NIGktIUrpDxDSDwVL9dQuz0imZgT6Zpsqc9cT1L0nEviv+4eO7qw3J+khDUAvv8k3aXw
         5zdQcJhXlcC51Q3gRM8bzFy8dMCq/+CAwaxCyWfJ0CRKeyaDJPa2R8lY2/SEw05HsrD9
         /WE9ODjrDSNd3130B8czmGQljXsTkKmhBJ2ESEwBAmTCTNySbRk1TAH4Jw9OYvUKZ4nY
         R0JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=JntWGuaqDI0hzwgZPo1rkEoUod1o9UwXPTEOmmqXQCo=;
        b=HsGqUhAitxnHu+T/GGWE17EVtkEmBkZODEvUZehJ3+FupBufMOJVOuZ62vExn0q58Q
         9+vuDudnQwVQUetMFp679dRqNhg08WQQuPC9pnv5RsPsY4kR6Fn22sL9JFh9Il+L1Vl+
         dJnoPO9tjnhVDNBZXnaRg5m2kH6abxroAfL915svnzERiMKxP+VwJWRm4PWlLgW9hNu4
         fSNoGEz5YzB0yJbqjpJE+Y24N8b6shV7VLS9YqhQUgFx/a2QfeJko5J5G08mmXc41Mk8
         ilDoChN83Jc6S4DpZn9Xrj5MjP4q484khBYxEY/q26pOAb1Zibj6yKdU4jFFH7SepmBX
         8mFw==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=nkKt+6p3;
       spf=pass (google.com: domain of arushisinghal19971997@gmail.com designates 2607:f8b0:400e:c00::243 as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Date: Mon, 19 Mar 2018 03:21:05 +0530
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: alexander.deucher@amd.com
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	"David (ChunMing) Zhou" <David1.Zhou@amd.com>,
	David Airlie <airlied@linux.ie>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: [Outreachy kernel] [PATCH] gpu: drm: Use list_first_entry instead of list_entry
Message-ID: <20180318215105.GA15431@seema-Inspiron-15-3567>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Original-Sender: arushisinghal19971997@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       dkim=pass
 header.i=@gmail.com header.s=20161025 header.b=nkKt+6p3;       spf=pass
 (google.com: domain of arushisinghal19971997@gmail.com designates
 2607:f8b0:400e:c00::243 as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-list: list outreachy-kernel@googlegroups.com; contact outreachy-kernel+owners@googlegroups.com
X-Spam-Checked-In-Group: outreachy-kernel@googlegroups.com
X-Google-Group-Id: 672804067692
List-Post: <https://groups.google.com/group/outreachy-kernel/post>, <mailto:outreachy-kernel@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:outreachy-kernel+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/outreachy-kernel
List-Unsubscribe: <mailto:googlegroups-manage+672804067692+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/outreachy-kernel/subscribe>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595313921234886794?=
X-GMAIL-MSGID: =?utf-8?q?1595313921234886794?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch replaces list_entry with list_first_entry as it makes the
code more clear.
Done using coccinelle:

@@
expression e;
@@
(
- list_entry(e->next,
+ list_first_entry(e,
  ...)
|
- list_entry(e->prev,
+ list_last_entry(e,
  ...)
)

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c | 4 ++--
 drivers/gpu/drm/omapdrm/dss/display.c  | 4 ++--
 drivers/gpu/drm/radeon/radeon_sa.c     | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
index 3144400..646f593 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
@@ -158,7 +158,7 @@ static void amdgpu_sa_bo_try_free(struct amdgpu_sa_manager *sa_manager)
 	if (sa_manager->hole->next == &sa_manager->olist)
 		return;
 
-	sa_bo = list_entry(sa_manager->hole->next, struct amdgpu_sa_bo, olist);
+	sa_bo = list_first_entry(sa_manager->hole, struct amdgpu_sa_bo, olist);
 	list_for_each_entry_safe_from(sa_bo, tmp, &sa_manager->olist, olist) {
 		if (sa_bo->fence == NULL ||
 		    !dma_fence_is_signaled(sa_bo->fence)) {
@@ -183,7 +183,7 @@ static inline unsigned amdgpu_sa_bo_hole_eoffset(struct amdgpu_sa_manager *sa_ma
 	struct list_head *hole = sa_manager->hole;
 
 	if (hole->next != &sa_manager->olist) {
-		return list_entry(hole->next, struct amdgpu_sa_bo, olist)->soffset;
+		return list_first_entry(hole, struct amdgpu_sa_bo, olist)->soffset;
 	}
 	return sa_manager->size;
 }
diff --git a/drivers/gpu/drm/omapdrm/dss/display.c b/drivers/gpu/drm/omapdrm/dss/display.c
index 0c9480b..fb9ecae 100644
--- a/drivers/gpu/drm/omapdrm/dss/display.c
+++ b/drivers/gpu/drm/omapdrm/dss/display.c
@@ -158,8 +158,8 @@ struct omap_dss_device *omap_dss_get_next_device(struct omap_dss_device *from)
 				goto out;
 			}
 
-			dssdev = list_entry(l->next, struct omap_dss_device,
-					panel_list);
+			dssdev = list_first_entry(l, struct omap_dss_device,
+						  panel_list);
 			omap_dss_get_device(dssdev);
 			goto out;
 		}
diff --git a/drivers/gpu/drm/radeon/radeon_sa.c b/drivers/gpu/drm/radeon/radeon_sa.c
index 197b157..66c0482 100644
--- a/drivers/gpu/drm/radeon/radeon_sa.c
+++ b/drivers/gpu/drm/radeon/radeon_sa.c
@@ -158,7 +158,7 @@ static void radeon_sa_bo_try_free(struct radeon_sa_manager *sa_manager)
 	if (sa_manager->hole->next == &sa_manager->olist)
 		return;
 
-	sa_bo = list_entry(sa_manager->hole->next, struct radeon_sa_bo, olist);
+	sa_bo = list_first_entry(sa_manager->hole, struct radeon_sa_bo, olist);
 	list_for_each_entry_safe_from(sa_bo, tmp, &sa_manager->olist, olist) {
 		if (sa_bo->fence == NULL || !radeon_fence_signaled(sa_bo->fence)) {
 			return;
@@ -182,7 +182,7 @@ static inline unsigned radeon_sa_bo_hole_eoffset(struct radeon_sa_manager *sa_ma
 	struct list_head *hole = sa_manager->hole;
 
 	if (hole->next != &sa_manager->olist) {
-		return list_entry(hole->next, struct radeon_sa_bo, olist)->soffset;
+		return list_first_entry(hole, struct radeon_sa_bo, olist)->soffset;
 	}
 	return sa_manager->size;
 }
-- 
2.7.4

-- 
You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20180318215105.GA15431%40seema-Inspiron-15-3567.
For more options, visit https://groups.google.com/d/optout.
