Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4151933-1522302744-8-7734606705894324276
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES ensk.us-ascii, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522302744; b=qefDWABX+vNoMkDtvPSphcdfVdNoNF6XUEg0SfLOuO2ahaS
    wlAGU1GIXeHWnILFeLVqo5u8UToRILtPziHUUURKgacOIJWK+AmT2OeaObKKHGTL
    2M2dm3Qxn7OpDvmejsEnRq4p40Lkn1cNrJmVEhs3OQNYPKE/v8FKpNBjzQcK22FH
    DgkUScqqkisLHyLPgqoOCGcA7wsC/rvyxuXlPGMs6czWVWrKRWJUaJ8N85xENqYR
    mnXnd0VFwG22PVk06T9+TCFCDlgW3kBXQu+FxMgcSb2TyiH37neF/Kt+RMoS85gX
    hg9dE7tSysYPIajyhpoWwL3Af+AQObj30btwWEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1522302744; bh=x
    C22C5PZh4JjqDlK3A/G910t5vqAyTPo4kbtivfl5Yk=; b=bCJv2Tp8tp//alGSS
    ciFo8TK9+t3LaBt1fdxd21vUpbGnbuKv/UvvkF99gB/dEZffGesSK0cZdROhxL8q
    +E4yS5Mwjv8UVi0YiOa80UEu/DTRHLs75DOakN4sVKjYzSWonk/FS6tWGzF6eIcF
    zDX04g0aZYyNvm3Wm/HUrTm76cDMZoNjJBq810QZ392w1SCnafyb/eooQU+h8DFi
    4J0/Nrg6c69QaVuFTjBlcTah4l/HWX1qetJ3eB7/QHxMQzzVq1nYqq1vWsz+yMEQ
    m/IvzlpuU9c0eNp3vBAiKwp4PMGvDv/foKC8CPrviXaLOyPxmRW50JOt10jtUjPQ
    YJcPg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAC/Vrcid503Oo8XGf7+MODQGFR2eLamxYYHBgS2dv98getqymh5ZYRe8qEmx6v3+teJbKmAL91CXtMBbJkfumWLgtFK57/6M9N+fcgvPBYqnR771ivi
    HHQBGM90EYUKFMcEQV5R/xjVFv8V9iHsqs4I5OZQ/m+VM+mQ5Gvn1sI1ESJKISFkm33B3YxUnlHgZPz2VXbIQlOVrxOJr4dduP5BPh8XI1uDUWpuUQFmQ2H2
    5gy08Rnv5QwlCeLkBgYVtw==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=ZQYQ6Chp1jm9kK9O5HAA:9 a=fLWBjZiCSVLFb5tp:21 a=bzeb67ZDRaApH2kn:21
    a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH 1/9] staging: ks7010: Replace manual array copy with
 ether_addr_copy().
Date: Wed, 28 Mar 2018 22:51:44 -0700
Message-Id: <20180329055152.13059-1-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
X-Provags-ID: V03:K0:+g0uh02oW7cLlnEWS12jiuWp63q3Auo0mspUCSi3iZBO2qvV2zP
 epMD+fEGMnk3aViWCwDpl1wwA/zwdNAz9/8dy0rBvstCic5SY4ug6s5FcZHLXtaEPfBFvBD
 PsrMeY0ZOxNog9bGMnlrDYBZpqDGIMJLxgH0Y8UKIK5CDQBJX61lQZHr7wQ9ePiVzjxSWjq
 5XHHdLZs/IUNhIoqeytvg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lRoyE9J+UnY=:pbMrVtIphmc0/Ycj86DMOy
 o3SG5t/moEe6U0ImfFyBNWIy2VXZOSuNTcDo3Egg1+hmpM7WuXdWbChdD/Sqa0dVpaprNuWAB
 z18onqyH9Cr1qwGA17z4GlpE7DwCtKxzOLjlNGGDBn9d5crB+EYNN6CSIk3lE8HG7Etag3O02
 1Z6yHW9UB84uVqKiYlCtcH/1ryzD7HYKvMjuQEBv/9Fms//D7y5VAQxEnfhbwexTHUwkDA0/F
 1CN5r15IKilEaJN6C8BThLRhTusHBUyIAUh3YBVHjq4Zc38N6u3Y3oxg3xo0hDiPxUO2CiRk1
 cCI05zPbO8TFZOoGX0Nb+CUCeNoXjXzm1ho4n1Kbcde1Qc1CH1C9k1HK77o907D8uV4Gc/CNO
 LZd3THbZyn+zz92FZOVOTpEy89nCmV7SUZaxLz+tnuvOhK/ZmzeALe20Dva6bzcwIsph+dUoy
 gUrTECQfLuvXJMwz+woeNK+FYsF423gwn7N643t4xFrfrwjyZKMlQqEjcf15+RjArV92hI97K
 y4WvWlw6vu24PLFxQ9eAPh+/If3vaI3nIwk3C9IrYmhTUtVHsh61H4wMN5Oqv1DReF3hJVl6T
 IX+FMTa2JPPX3hjvC1XXTAcDmlMp4baoKmQ66Q5+Bc53kheFTPjv8rgHsbI4xW85XW7TRbOrP
 7m0ycEwvUcP01AsQjD+1M+LE85iiDFAIpHWFiv8KFAWk5zav6Qqtoxp2zn/rfjr7mtd5hb3pH
 CqAwuKn/wIKrfZTtByLjBhT9tejeSHnm8klvsA==
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, driverdev-devel@linuxdriverproject.org,
 linux-kernel@vger.kernel.org, Quytelda Kahja <quytelda@tamalin.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Copying the dummy HW address into the struct net_device doesn't need
to be done byte by byte; use ether_addr_copy() instead.
Additionally, dev->dev_addr is not eight bytes long.
ether_setup() sets the dev->addr_len to ETH_ALEN (defined as 6)
in the net core code.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_wlan_net.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/staging/ks7010/ks_wlan_net.c b/drivers/staging/ks7010/ks_wlan_net.c
index 6106e79c5163..f6e496aa68de 100644
--- a/drivers/staging/ks7010/ks_wlan_net.c
+++ b/drivers/staging/ks7010/ks_wlan_net.c
@@ -2900,15 +2900,7 @@ int ks_wlan_net_start(struct net_device *dev)
 	timer_setup(&update_phyinfo_timer, ks_wlan_update_phyinfo_timeout, 0);
 
 	/* dummy address set */
-	memcpy(priv->eth_addr, dummy_addr, ETH_ALEN);
-	dev->dev_addr[0] = priv->eth_addr[0];
-	dev->dev_addr[1] = priv->eth_addr[1];
-	dev->dev_addr[2] = priv->eth_addr[2];
-	dev->dev_addr[3] = priv->eth_addr[3];
-	dev->dev_addr[4] = priv->eth_addr[4];
-	dev->dev_addr[5] = priv->eth_addr[5];
-	dev->dev_addr[6] = 0x00;
-	dev->dev_addr[7] = 0x00;
+	ether_addr_copy(dev->dev_addr, priv->eth_addr);
 
 	/* The ks_wlan-specific entries in the device structure. */
 	dev->netdev_ops = &ks_wlan_netdev_ops;
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
