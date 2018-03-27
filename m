Return-Path: <outreachy-kernel+bncBCAMTT4T6ABRB4535HKQKGQEJ77VASQ@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1522163188; cv=pass;
        d=google.com; s=arc-20160816;
        b=Zy9Ti3ZmbJpygwuD5M+5rP/VLrd5ukZtF14UOsWUqNzwkwMqiLqOCjfxjCX71QVgua
         IrSZDFQQ4NUw4JJBRNwKYP7cWMCQcdFTOh0p8oYVYiAPjgdl+Bs3aYF/HV+tQwrAjiAy
         w6TAeVSzHolMnh+D4xoDnbNalV55gRAtZM71WTFdw8gSCHWRCl4Y3B9EP6IyMhLM+8E4
         r1wPlc/LDvcaisu/n1mb9l5m2pEXnEdT660/wgu+VuLse3/gBrtePgzRDoulk30c2FYC
         9REIZboQtgQucXpFpH3IRSHcLEetcS8cqd+HQUacYQRctBBoNo6fYLcKmIcMCcYvd6N0
         CrWg==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:user-agent:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:arc-authentication-results
         :arc-message-signature:sender:dkim-signature:dkim-signature
         :arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=IqnO4nSFpwMwi6nhHE/lG0aFrzCrzjNiDJEvN3L9UN4=;
        b=UWH7ThyVakiP/RULP17LE1vkcY4tYy7HU+Z5ec1rV2lO4LUjPhhN3wCKspNCttrZRA
         /ZuSA6U1BZGHLlHOHdMJXVfqo1EPzq4gJAX0EWf9V/WsrBZQZ1Dspk90a6BcH59I8xoZ
         qfONAQUeqrt7iRtzcnMZ4bxli9IoD7vz8rmuD6nOHFI9djDfAMorFRP+46IfchXIi9Te
         CfGOb/SMB5L8jTcwhGaBNj7rVBqx2q11F5Js1vHSGropmPWjXhfPgTQ7p+xpCpRBh+hP
         umPDMO2rMDBklviHTOpJQPujwkHWSw93dKUi9Jd8HfS+BaPMJmwgLgcT5EIdE0WYjEXJ
         oE/g==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=Zq/wGKRZ;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=s98TTrAc;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbcamtt4t6abrb4535hkqkgqej77vasq@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCAMTT4T6ABRB4535HKQKGQEJ77VASQ@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=Zq/wGKRZ;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=s98TTrAc;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbcamtt4t6abrb4535hkqkgqej77vasq@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCAMTT4T6ABRB4535HKQKGQEJ77VASQ@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
ARC-Seal: i=2; a=rsa-sha256; t=1522163187; cv=pass;
        d=google.com; s=arc-20160816;
        b=XMzotHpy+j6F9/IXKtZ9ZCKFae4PUx3XoC04y9pkL0YnMDY9RcTFp3/2fxJNHDarA3
         yfM+HpL9BSeKCIg3Lnz9ThB+YiZMWJGyL57BUaHbBWdP2+xYj78nzqAeYBBCj5EPOydE
         CWIpg5K6zwNU8OJBgNSNzpnYkpZErqbJji8eKYfNU410E9npIEokvwU0Tg9EM2SczgeY
         VZ97U6RCvW9OWXXfFwjyA/7Iips7ji/NlavasJXU0PRjzGAJGYZG4mToiyEeE0mVlkI4
         3FJ7DBjhspLCkAnH6DhHgrfVURN6KirpSWBuJHB3pWjyAHqQT/6RsdulLF1Oho/u/L9d
         Zs5A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:user-agent:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:arc-authentication-results
         :arc-message-signature:sender:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=IqnO4nSFpwMwi6nhHE/lG0aFrzCrzjNiDJEvN3L9UN4=;
        b=ZAZACoB1x9uuTZSlTFNwVxre0Yka3qVvepCHiOYWDJ7opCwDswF17yynegyKX9VYOD
         nm6QYLOc3nx1OAuEWIF+VNnhf1QvaBky1l9MQzoEAdrS8UbXudPlhOSa33T7jdx26rlF
         wi30h852bd1Hg4sZ3k90hn5GKPf0682PdEWTPkrO2h3tOHDJ8NN6KuqZLEz+h5cIOdLC
         2LO8mv2Mg1VHm+LnfdGs75+vOoP2y7TPxEu++/l2z16iF5iE3iw23dNGHLiNgvwf1rHA
         Vj5pT775U+MBZn+F1rK6zqdKASANn+OFMXIvwDZwqYzsoJwFXpTO9Nr9hZHHFNGXfOsR
         2b+Q==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=cpFVcFB8;
       spf=pass (google.com: domain of arushisinghal19971997@gmail.com designates 2607:f8b0:400e:c00::232 as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AIpwx48nu1ddVxiQzJPjef1m39UvCNmebPYalwurFWqbIwIfX7GlkDZJMZ3FRoLsanNSif10fvgjew==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1522163187; cv=none;
        d=google.com; s=arc-20160816;
        b=cP/AmkMvzS2VlgCDF4RweBOnwNbzSIB6YtHzamS0CekkuP7QF96oFDcVgQlgoG5uxa
         IIiWjkaZalwpXXrcsP+o4HuiAkVAvNxG4iTWGoOaS+RiflF5aRtze0jSMz4FZ0kpOza7
         l8QB9IX1X8AePQUPnDjtyNzZL7m4LGhAVNEPVACb1OfSFpgQ3iRmR2xCqEsWMDaBjFO+
         e3wiBULlsmsgxzvxhOhNlw8V/npnnhAg1kXvbg31MVqemgi+wY1D+rs3A+7ReIlZ2HB7
         dAdpTvNj1V/jz725HQ+FcigpqVY5PVALHtR+xctZsbKQw4GRuWswx/duthOnQNDXI4eL
         yVvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=o8gJmUeAbWbO9nEBpomjpBeAmY63gDwZikydnRtRvoE=;
        b=zGQ4LQNhKmZAEDVUASOaucUPeC8XK9uzUMpt0RbCffp5Ql6V6iJuoViXFRdRj1Z0nf
         ZJDQ2jaWzFoJiKRd7CfQvbsd5lpk3HejY8ztdginXnsDVDCM5uzZ58Kgvwhu7pvXrtsP
         SCkBJfyXsBxTzwmb8va/+3DqYz5PdiTsMEHme5c0QUTPu/apsqjiisWsGTYQhtmig3GY
         YU0ctdm7tDElCPSO+9U+DtLxJQ9Vz4LME8syBdb9oTJ8rKd2GwOOs30HKWKT1N+NzYho
         5fMZ5XmimdPavwwAVc/BN064h8Kb+ejBlqK0sYOl1yfS0iWmy0CwA4hf6gb1KmW/8m8q
         QUtQ==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=cpFVcFB8;
       spf=pass (google.com: domain of arushisinghal19971997@gmail.com designates 2607:f8b0:400e:c00::232 as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Date: Tue, 27 Mar 2018 20:36:40 +0530
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: bskeggs@redhat.com
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	outreachy-kernel <outreachy-kernel@googlegroups.com>
Subject: [Outreachy kernel] [PATCH v2] gpu: drm: nouveau: Use list_for_each_entry_from_reverse
Message-ID: <20180327150640.GA17832@seema-Inspiron-15-3567>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Original-Sender: arushisinghal19971997@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       dkim=pass
 header.i=@gmail.com header.s=20161025 header.b=cpFVcFB8;       spf=pass
 (google.com: domain of arushisinghal19971997@gmail.com designates
 2607:f8b0:400e:c00::232 as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
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
X-GMAIL-THRID: =?utf-8?q?1596081478733159476?=
X-GMAIL-MSGID: =?utf-8?q?1596103787367054485?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

It's better to use "list_for_each_entry_from_reverse" for iterating list
than "for loop" as it makes the code more clear to read.
This patch replace "for loop" with "list_for_each_entry_from_reverse"
and "start" variable with "cstate" which helps in refactoring
the code and also "cstate" variable is more commonly used in the other
functions.

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
changes in v2:
"start" variable is removed, before "cstate" variable was removed
but "cstate" is more common so preferred "cstate" over "start".

 drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
index 81c3567..ba6a868 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
@@ -109,18 +109,17 @@ nvkm_cstate_valid(struct nvkm_clk *clk, struct nvkm_cstate *cstate,
 
 static struct nvkm_cstate *
 nvkm_cstate_find_best(struct nvkm_clk *clk, struct nvkm_pstate *pstate,
-		      struct nvkm_cstate *start)
+		      struct nvkm_cstate *cstate)
 {
 	struct nvkm_device *device = clk->subdev.device;
 	struct nvkm_volt *volt = device->volt;
-	struct nvkm_cstate *cstate;
 	int max_volt;
 
-	if (!pstate || !start)
+	if (!pstate || !cstate)
 		return NULL;
 
 	if (!volt)
-		return start;
+		return cstate;
 
 	max_volt = volt->max_uv;
 	if (volt->max0_id != 0xff)
@@ -133,8 +132,7 @@ nvkm_cstate_find_best(struct nvkm_clk *clk, struct nvkm_pstate *pstate,
 		max_volt = min(max_volt,
 			       nvkm_volt_map(volt, volt->max2_id, clk->temp));
 
-	for (cstate = start; &cstate->head != &pstate->list;
-	     cstate = list_prev_entry(cstate, head)) {
+	list_for_each_entry_from_reverse(cstate, &pstate->list, head) {
 		if (nvkm_cstate_valid(clk, cstate, max_volt, clk->temp))
 			break;
 	}
-- 
2.7.4

-- 
You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20180327150640.GA17832%40seema-Inspiron-15-3567.
For more options, visit https://groups.google.com/d/optout.
