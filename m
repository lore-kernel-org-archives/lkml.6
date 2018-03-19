Return-Path: <outreachy-kernel+bncBCAMTT4T6ABRBS4KXXKQKGQEISTHQEY@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1521435979; cv=pass;
        d=google.com; s=arc-20160816;
        b=D78H3U3p3Ws8FTbCJhV7OlIWp2TWu9pD8XhtxZdOqfI1sBLW89Z2d7T60hW8eL2YZc
         kdTqrcZGLB8uqDiywxEaspM627sIGrFp68uCqmYpBKdE/LbZfGxbY4KHjODuBvUy+vPk
         PlhGMeyykOZ1oDltqGoeoRoDdB39DVEYK6NK/uzKIgf4f57TFU5Vw7pFv5Rh1Nf0wZ0o
         5qHbvlzowhZ0T8uRZep14AH61aM5XP6sHg9qGH+6h2hI+zSI+rZAI4bGYSaYFuCVAaeN
         JzQj6MKsuoiCQSfxToM07OvNtsPgchjllqdsTElqOe3kFKzD0pik0fKzHABKDKQIV2PP
         GBbA==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:user-agent:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:arc-authentication-results
         :arc-message-signature:sender:dkim-signature:dkim-signature
         :arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=yN+lduWOr2ffoV1BxpcqCEQTdYWQIJD5oQEPg05Aop0=;
        b=b0p1Gknp2/nJwfnwGdCVV2sTQu3zqpx2je3UcZB+IAD6sauk2fc9U7JyiXEVlYmCDz
         fRsXSHTEDXaFTydiciPfjk3Rs4ms4PB1p+H+DT32NVM32HBzZfegGNyg7GfJyS93ND/d
         ASdrJdXUqNm5duB2vhsTfsXYGUiN5j1f65WcW3wGqzIiHFD9XG8ubnd+qKli2DZapgC2
         w4/c/V9gClJH/n5CbvaPTm7gLqTP3F8mb12OGqJbqImS+SE7BWd1/2w6RW8UqDdHKZ74
         v0nYB78b5DbSu8KKaD8xzFqX5B7BLNxkljokehf3U1EuaDOw8KhPEqFNoGjLmC398GYW
         CnZQ==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=W8oOkOf0;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=LVsYL4aC;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbcamtt4t6abrbs4kxxkqkgqeisthqey@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCAMTT4T6ABRBS4KXXKQKGQEISTHQEY@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=W8oOkOf0;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=LVsYL4aC;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbcamtt4t6abrbs4kxxkqkgqeisthqey@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCAMTT4T6ABRBS4KXXKQKGQEISTHQEY@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
ARC-Seal: i=2; a=rsa-sha256; t=1521435979; cv=pass;
        d=google.com; s=arc-20160816;
        b=SShpIrDS170am5ffRRETwpqFfe0QDNFPkRPj7SlWHvFT4Hn8Tdt4BThlfXwualAPGf
         S+XEYdTaLYa7mOeF8XhEL5+61YqF9VFDZjOe/KNDHxfZaBShzZT6gvWqCropb2AH11bO
         WywfV2q14x1I+6qhbDq53BtrtL7qOE4LNYHfGwqjjkbps1Nlr38TyDEuaHUU+QLacd4L
         B3yAhqACR8nSiqkJelHJ+eD/g97p+v/QadiI+AZV4IMvMApFDHKxYBX9oe3jbaQ42dv+
         raEJe2JR1F/lJL1vXW4fRrxS9Puq2RATOehYEJwYgM1JEHI9UlOu6FkwaeoMVZZwXOFx
         iakQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:user-agent:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:arc-authentication-results
         :arc-message-signature:sender:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=yN+lduWOr2ffoV1BxpcqCEQTdYWQIJD5oQEPg05Aop0=;
        b=twzAXIwdvw/BxcfWnpYDgvPf16fPc5NUL0HA45b3jk7to7blxVQRKHTr7UcRv7alJa
         dvefBFdOZOtTl6VVHKYmYEnC2djgkQ8VXZqLKlD1O4EAo+xeg4/G/BDy2H/G09PFKC7s
         QefWu3zqKHILrveKLbX1M+3uckCBVlmt6QQZ0NnlVCY5pu+dECcZsQJ3gt/JJr+iBbXU
         5uCVKerLifMtisuM/LJreCaoDHRPZN/5Xrz+vIqpnhCuNN45MdLBlCFovDwDJmjvjkhr
         nj6nhwtAESbMeIcWLRAQmrMXLQWus67FisvYIl4v1KPOWF5vTgZUU7H2nUy9jcVFELYG
         nBvg==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=mq3MGNFH;
       spf=pass (google.com: domain of arushisinghal19971997@gmail.com designates 2607:f8b0:400e:c00::229 as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AG47ELsHAwKClJ1uVZuMqiKD+XyaQrVfw4If8rJqczO3dl/q8hhV650NySADt+aNBAnkZCOVgmctgA==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1521435979; cv=none;
        d=google.com; s=arc-20160816;
        b=N4SYFvhvNXkY5131GksgOIb3dR4ZPma2d/sy1P8bOjvSuhyEUTNV5qDz9oIXMSWANZ
         kM8/RMxqvazMLW+QwYdmEzBgXA6acl3R8n5Giv08ytA5M0WFVt6ekUDAcNDVvSrAzGvc
         Fg9cY6c608GvG1zr788hTxBoINK1Yzpy97/PSAQuHRc4ZANOi5D21/nHiYl7vIGQsC9W
         Ht0lepmOvLDK8mezM4b218PJ5iLXKYAZgq77AWZCaPrWK2QCAaul9NIJeBpcyA6ZMwvJ
         mYmd713MLQiG95BuCDCfqIbZUKwOznuHZg29g7jVH6VEAXn/YPRPTyZfw6uUTUO75/g+
         X5SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=bogjxT5foVjfJNH1lZulBwMPXHpUymaL0kO6YYtCXQc=;
        b=kKNTPrh+0G5WwOvf0jd0U/P5RBr+o0qjgvAQ+hq2eEBM/W+yvd+wJ3xnURfg0BfX/B
         bAd7EBxJjvIyi8CrVkLRD9shF9Qnx0/IAfodDR+DG9fLg2WyWh6slJY60r1aVKOZXyMc
         dbaU+pJx+Ka56Dq0UreYzzSUQsJyc7xn9qj7ejlAuJDAB/0ANGfL65Ei3C4Ov5kRHpsW
         a6qCm90EFUY6c+g4ZNxZJbpIs/uo4E3CSf5Fssm1j4lA9jCk3nRPdIb+XF/anoERvgOM
         i4nQaiNe3HroZE0+SsM9HimFBRjb+V+iO9KBM6Y7IOgliTFJpoFkzWiAWF0rtxHb4lLf
         L10w==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=mq3MGNFH;
       spf=pass (google.com: domain of arushisinghal19971997@gmail.com designates 2607:f8b0:400e:c00::229 as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Date: Mon, 19 Mar 2018 10:35:30 +0530
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: daniel.vetter@intel.com
Cc: Gustavo Padovan <gustavo@padovan.org>,
	Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
	Ben Skeggs <bskeggs@redhat.com>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
	outreachy-kernel@googlegroups.com
Subject: [Outreachy kernel] [PATCH] gpu: drm: Use list_{next/prev}_entry
 instead of list_entry
Message-ID: <20180319050530.GA25589@seema-Inspiron-15-3567>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Original-Sender: arushisinghal19971997@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       dkim=pass
 header.i=@gmail.com header.s=20161025 header.b=mq3MGNFH;       spf=pass
 (google.com: domain of arushisinghal19971997@gmail.com designates
 2607:f8b0:400e:c00::229 as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
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
X-GMAIL-THRID: =?utf-8?q?1595341254275374860?=
X-GMAIL-MSGID: =?utf-8?q?1595341254275374860?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch replace list_entry with list_{next/prev}_entry as it makes
the code more clear to read.
Done using coccinelle:

@@
expression e1;
identifier e3;
type t;
@@
(
- list_entry(e1->e3.next,t,e3)
+ list_next_entry(e1,e3)
|
- list_entry(e1->e3.prev,t,e3)
+ list_prev_entry(e1,e3)
)

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
 drivers/gpu/drm/drm_lease.c                    | 2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_lease.c b/drivers/gpu/drm/drm_lease.c
index 1402c0e..4dcfb5f 100644
--- a/drivers/gpu/drm/drm_lease.c
+++ b/drivers/gpu/drm/drm_lease.c
@@ -340,7 +340,7 @@ static void _drm_lease_revoke(struct drm_master *top)
 				break;
 
 			/* Over */
-			master = list_entry(master->lessee_list.next, struct drm_master, lessee_list);
+			master = list_next_entry(master, lessee_list);
 		}
 	}
 }
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
index e4c8d31..81c3567 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
@@ -134,7 +134,7 @@ nvkm_cstate_find_best(struct nvkm_clk *clk, struct nvkm_pstate *pstate,
 			       nvkm_volt_map(volt, volt->max2_id, clk->temp));
 
 	for (cstate = start; &cstate->head != &pstate->list;
-	     cstate = list_entry(cstate->head.prev, typeof(*cstate), head)) {
+	     cstate = list_prev_entry(cstate, head)) {
 		if (nvkm_cstate_valid(clk, cstate, max_volt, clk->temp))
 			break;
 	}
-- 
2.7.4

-- 
You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20180319050530.GA25589%40seema-Inspiron-15-3567.
For more options, visit https://groups.google.com/d/optout.
