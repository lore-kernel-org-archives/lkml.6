Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2920516-1522393769-2-16369851326681446417
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522393769; b=g2ZVHAg047f3zvpoKrnk5P5POC3pLyeSRa9sn16V189oHSbtp4
    kqll48MvyZSdWf3EFb98rHgdpU4s+OTqRkIsw/+GFfxpRgZ8D3p/n2saIFPQJ9Iw
    PlJnXKTqnzjKYKodl0NuSAQ0tux8Du/8F6sV8nqxoHBfZ5G391T1qlKQFgoAVxVn
    EromcrwLDDTXcPNj2wEDD4g8fcZ2ulN8TchUCx5Gxgdeo1OiNHsXmCq3UOry+/3k
    x8biPznrGehYZLGXzr2J8WdkRwn8die0DdSCO4iwxhFfkO0nrcqhBeVOdNvEf85q
    Gnz+H1aOXlU8vDO3XJWgUqjT4WteIqWsZCnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522393769; bh=B1/Mw
    WdxCf0+5ytdTCUzUuZWtuh5G6Agw/J2QFlyL1k=; b=BYU+HjuMGq4XEZ7frrHRt
    3aACZyz/8+D3itVksHNYDEa9RCLUytsmNjrchIrciHenKhuuS+HNplV4jzl/IadM
    BOboKeKGYLIjpG6Jt1cQhDxnhGwJBvH+1tYyQ3vfKd45J0fvjwMP11yuIfbdIpto
    r4aR4HFug58UzZu7DPD3iIO6338ahGfhZIZ0/EoTBJpSBlXlbYux4/tKPcBFNVu6
    kgivibgCBtbrVezpTBSLA/uGIF1jeJ9TOQQIfV9UmUueD7qSPdxC2o/qigQ1Jjj+
    WxclvQx/LjgydVIEIGXbBM+T7Zpo+uxSPOYskwwyrvjw6KcvjgSfnNV+YHgyysou
    A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLW7Owo8So2qTiL39ENXVVksXst7cB0cIDZFmWGwa7FfjAalBmyXy73D51mC3rqwh8Z8eY8vSzHXw69kxGZZb28madi4Bp0a15pAuXbPigw7s7uwtURt
    zGM4T13S1kIMVVj1v6bYK9AIbr+1JieS+yS9QYPajnoLt/4n13Ne9mYazeIkZroHTU8HxQ/z2CnHSHO0IJp43zgZBxA5oMESTqhDH569WNV74kxew/h/LRVk
    PhcEHOM5xe20TlxPIjXRrg==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=4pWhBJYePLsalNw6YyoA:9 a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH 03/76] staging: ks7010: Remove trailing _t from 'struct
 rsn_mode_t'.
Date: Fri, 30 Mar 2018 00:07:26 -0700
Message-Id: <20180330070842.25224-3-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:hGSgru0EgVrkL5Ava6p0tCtkf7c+jCx3ijrQsgxcm+9mpK1X6Re
 JFyJBLTTkRy6lqGlHKJsvmjQhfmJuly0s818tWgViFQ9Y24kn5zIdIsP8wwqW7N6MeL8pO8
 apHWW2/XmiWKTcPF4ayop65ZZ6FBWbBjuLpAB3ga7sdY7jWvE/xK8hj2e0RBnl+6llv0bOO
 PjC435KczQ+vq6FzX8kWw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Oyi5yU7kiD8=:meekTLLMWqpMM/wOrHF6ey
 DbtVKdZKWxLEKbQymyA8I8QJBSsntIPinLj7mky+BEY2Cdk+Ok3qlxm6SMs34ET2ePUFhwCBY
 K0UwxbtNhzGxi8r+cyv+6xPkcuaGkzSQNdl17trHk/boSI1yp6hZrQLdnBmZJ/TOFfSVFK2t+
 WFzZnRX7F5pQtWGA0IQVtVdIa/+OvOblLE5MR9UK2O8Cc8Q+NqT0oKaMwu1IlN0mhwxwd9I0P
 9s0WvaA9W95uLwiAdkqSXj2gMDSOzqztE8JRMBMW9lM6g2XnuyJF7fH2XIFUMrcAC2X3rtesd
 vrJTkezxfxMH0BSSVq5Rfr2erXyh58xtd3O1ATHmMbLYhkOgC5QmjwXUMcFNjQ6UFPlHpZRRI
 CCTgzSvB1Zfx3HPbHNVaFuypIlXNUA1+cVEMHre5dJK0u6loLpov3P3Rrd07zISZn/WooskhZ
 8V5bm3tUkFt8yEpAzx4L2coVuq1swgnoqKVnS8CTyYsD71C9NqFye0klBMlBPhJuBRaqg+UyB
 m+QBg/jKuNiz//lyV+r6bCbdPXvrmQcoK62BFs+6bAqezVRUja+esdQXdLlLMKzkUSRKJXd70
 maX9YsKTIaSPyyIcILYoMdf23SLx4fq2p4BWW/NW7acTzMcNA3YGi1+A05BS+PfIRU1J2mCRz
 blfCfNyGGhHfBGEM01M87W8Cjkg+Yhhk2WUwzWHAPF63xfqMIeAWg2FxNgUUZCgTagtuIqcyF
 tlwmvo8sojFwuLzfSowPEJ3znWGgMf8o0M8T2g==
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

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct rsn_mode_t' with 'struct rsn_mode'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index af1a5c123789..8c269624401b 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -1665,7 +1665,7 @@ struct wpa_suite {
 	unsigned char suite[4][CIPHER_ID_LEN];
 } __packed;
 
-struct rsn_mode_t {
+struct rsn_mode {
 	__le32 rsn_mode;
 	__le16 rsn_capability;
 } __packed;
@@ -1674,7 +1674,7 @@ static
 void hostif_sme_set_rsn(struct ks_wlan_private *priv, int type)
 {
 	struct wpa_suite wpa_suite;
-	struct rsn_mode_t rsn_mode;
+	struct rsn_mode rsn_mode;
 	__le32 val;
 
 	memset(&wpa_suite, 0, sizeof(wpa_suite));
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
