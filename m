Return-Path: <outreachy-kernel+bncBCAMTT4T6ABRBWEV5DKQKGQELFORM4A@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1522141913; cv=pass;
        d=google.com; s=arc-20160816;
        b=1AnHZv7iX0T3xUJBsgwZsue1u5plKXuW/uDIFx4ToZZrvZ1Ei/V2HaUfgZLonoOLUj
         khBua3XzChOSpYzcr1+Vi3tmiz/ngBCEyvfnu82qY8h90valtDWZ2/0ZvgrwwMqOdpIM
         pfAjOw85cGN0hX7NAenl34B/XNl/XkWRF/4kqyet481oSg1jR5wuLRP80U9M/etWf6Fy
         p7xK/9qNwgF5BM2zbSpaqXNz2xGeLG9sKzud76794d9BAylL7vTR50A7NayLd8aB0S8P
         AOW7krf79ziym9d/jPnTCzGCz2HmKRLuecVjpv9+PwtT3ijteWtFD9hHNVSgfY0dTvDd
         DbWw==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:user-agent:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:arc-authentication-results
         :arc-message-signature:sender:dkim-signature:dkim-signature
         :arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=U1/isspuFdczTTFT3IEOq2sF0sR4wpl3Ay1Gyj5riIQ=;
        b=iUyaN7NA4r43egWBEkm2hylYUWw9Y4joz9qZyNrnEkDPA3YmhhNVKTls6JkUh3u/hM
         8hcat6BEh7+M8xlITLviMnhBHIEdJJZZyj8Ra3kDtkMcnN5yd3f3+CSsZOowrY5hWg6j
         LMtoPnQv52za0zKYp9wYOA2lvfrkYNDLrh2kNiEo3vXF3GomLXWVsVKW1uE6F5wUshjA
         OdbYGXsIf7HBZ74G4poPhP0Yk3205OWhVtGSFOvKpy7NrhrgwIOX2Jsr2NcvsJVPfFol
         Wk9Mhq4eLqGsD3sPVxT0iBRE5wVNohSp5QwvyUCfLv9nLLD2i+GWyeSEYL716Kq6EdwN
         qrRQ==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=prh4RkE/;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=u8rzT1Gb;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbcamtt4t6abrbwev5dkqkgqelform4a@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCAMTT4T6ABRBWEV5DKQKGQELFORM4A@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=prh4RkE/;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=u8rzT1Gb;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbcamtt4t6abrbwev5dkqkgqelform4a@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCAMTT4T6ABRBWEV5DKQKGQELFORM4A@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
ARC-Seal: i=2; a=rsa-sha256; t=1522141913; cv=pass;
        d=google.com; s=arc-20160816;
        b=Eqr8dsbgo5tqSAM/cEHoCX/CaoFAl2VhNYg16kn5oSQVMxjH1005MYBmDoKJOLkfwA
         baPtakZpDK7NKuZKZy3q3YhZGA0qTGrYdRM1Fuqzfd6P3fWEOF75M5XL0T39AhsP5yeB
         OZYBmF1P7IH9bz1DTkJqzoBLBGTNsiUMmWKW8qmK/BKaRrWmKlIOBDKHHswByoxafo0q
         YXYwLMeQTQOADgQBoQIAKIuKyiERvbHO0w7aslcso+jKFQn/kCSK+AmqcTQSS21WUW1x
         U6vP2DERNnXSli+KRLJbRUgomEf7arJV99MnSGJPzHIsSEjc/Eh6yLNvjBW/qCkqpX7y
         VANw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:user-agent:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:arc-authentication-results
         :arc-message-signature:sender:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=U1/isspuFdczTTFT3IEOq2sF0sR4wpl3Ay1Gyj5riIQ=;
        b=sg3ADQMPDIJFXl3t1lblKfzUVt7k7WU5T49exiWAh/vu3FXAm6bft9c0d5Qk0MqjdK
         SwRdYsg6JuKvhWCcSQl0MLafL0vLvPlcMc6yh5ZnhmW+g6RBMcWbcPCgITMsCL2drWzM
         oSw4RGtlRgy3+iJBGOdShSnLUod6VmMyVycc9+AByCpx9TCUV7JZiWy5wQi35Z0XQM7i
         PsCe3AWRg3HDIPabtjcToY//+6R8j0krNmoPanD7c5VsborlmJM4T7gCXPWb0vQuyb/A
         tCZm4X67PznJZIRtdeplmo8M8OqX0FZvl+cPaUGGWwIT7rUs2ziV7XMrSj44Yek7IL11
         H1Ug==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=eaCgENgH;
       spf=pass (google.com: domain of arushisinghal19971997@gmail.com designates 2607:f8b0:400e:c05::243 as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AIpwx4/DsD4VnTGJ7LJ1/KwmjF4yxkODWGnujPAcqkyZnJFymptC5xUb6OH6UdfiAAngozHAfU1tWg==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1522141912; cv=none;
        d=google.com; s=arc-20160816;
        b=rFOWq3IxVsL5EY/UlavdQcFIUmLsfPRwtXkOojokzF0I8QqjFPDd7JbKYzJM+kdOt5
         /GSVL6FP8fw+7Y5rb3q+hY1F9zrsk2saXTcYd7wa/rCEVD+N0dSDA7sQoy20muCPrh4F
         nOuqUDDbA6nw+6UnHwhQmaLA7YvnUclapxaqMDQjFHYfPma0MSlcu8VhPwa0rhoq/FS7
         gTvlaqVrgmW7stSRP8SUZgyGtZrDpGI0FFvkArnFjgWassYkRWCqAosxoOk4no7aXzFM
         HfwtXJOZ2zP/WVngRukYZlItI5hlk2WZMJufQxs04f8ShA48ooceIIv135H4/2Trkn9d
         ItgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=B51rQGyYPVX1wUlufoKzjPSNN+MCDrsu+sbHwRO9DfM=;
        b=NfxtbwHQ4YQ8AhA53NJAXpOu8NNpydQ88A3kwdgWq+5TrRwMMe29wBIZRaa/vYOtCK
         VUfBCRNVmoeTOiMJHJoLoDE5KOKPHdeqhyGP6ReljAJ64zrcyVJ3MGh61dN8Ch90kGSL
         5P9Tra8myCpaEwz0L91s4BJaM615+i/Jp2WZIAhCku6IHgowBggZ//zNpevw4lFjwkMS
         s+myhuy9b44frOen9ninZ/V5Bc4FYY55+6xnWsopOuH2zqYsq/9etwD4GLCTQF0wqiQU
         TMxgbAqE7nsgTjaon3DSp7+gXkxBiEzipISELN12jV8TyriCTkC+yvNlGJ7C/rDOp01p
         Sx3Q==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=eaCgENgH;
       spf=pass (google.com: domain of arushisinghal19971997@gmail.com designates 2607:f8b0:400e:c05::243 as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Date: Tue, 27 Mar 2018 14:41:56 +0530
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: bskeggs@redhat.com
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	outreachy-kernel <outreachy-kernel@googlegroups.com>
Subject: [Outreachy kernel] [PATCH] gpu: drm: nouveau: Use list_for_each_entry_from_reverse
Message-ID: <20180327091156.GA23787@seema-Inspiron-15-3567>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Original-Sender: arushisinghal19971997@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       dkim=pass
 header.i=@gmail.com header.s=20161025 header.b=eaCgENgH;       spf=pass
 (google.com: domain of arushisinghal19971997@gmail.com designates
 2607:f8b0:400e:c05::243 as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
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
X-GMAIL-MSGID: =?utf-8?q?1596081478733159476?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

It's better to use "list_for_each_entry_from_reverse" for iterating list
than "for loop" as it makes the code more clear to read.
This patch replace "for loop" with "list_for_each_entry_from_reverse"
and remove "cstate" variable as it is redundant in the code.

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
index 81c3567..5e56f74 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
@@ -113,7 +113,6 @@ nvkm_cstate_find_best(struct nvkm_clk *clk, struct nvkm_pstate *pstate,
 {
 	struct nvkm_device *device = clk->subdev.device;
 	struct nvkm_volt *volt = device->volt;
-	struct nvkm_cstate *cstate;
 	int max_volt;
 
 	if (!pstate || !start)
@@ -133,13 +132,12 @@ nvkm_cstate_find_best(struct nvkm_clk *clk, struct nvkm_pstate *pstate,
 		max_volt = min(max_volt,
 			       nvkm_volt_map(volt, volt->max2_id, clk->temp));
 
-	for (cstate = start; &cstate->head != &pstate->list;
-	     cstate = list_prev_entry(cstate, head)) {
-		if (nvkm_cstate_valid(clk, cstate, max_volt, clk->temp))
+	list_for_each_entry_from_reverse(start, &pstate->list, head) {
+		if (nvkm_cstate_valid(clk, start, max_volt, clk->temp))
 			break;
 	}
 
-	return cstate;
+	return start;
 }
 
 static struct nvkm_cstate *
-- 
2.7.4

-- 
You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20180327091156.GA23787%40seema-Inspiron-15-3567.
For more options, visit https://groups.google.com/d/optout.
