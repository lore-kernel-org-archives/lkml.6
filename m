Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2920516-1522393777-2-227515321351760700
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522393777; b=ZHlrHDbOnLA2MegHIbZEG7qNRcBaOIzXfyQBUZnLYgAtSsqcPi
    iYIHBtippM1qsIFG34iZ3wHKk+J4E1JJ4XvdmxCBNvoSD08tNS6dRAgewIJX7jCL
    isw3cCX5ikipAl/VA/u55219v3M/zHqkpO/NWOkzhD0/f65Pm375P6i43wIyUywU
    wGxlAgmBPG5V19EGejvuEkEsBJQwsIbsQMImrW4mJ2mirtCP0BVBUjCSZrDv/su6
    LN5OPR7Uw/nkOo181nvdO6CnIXK0q9HOZSxeXhx6n3CPt4Q7DROxUfKLYBqDinHU
    27Ck6zDLzxRsb12wMa9FEyA7SuplZhA1VX9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522393777; bh=PYwuY
    ciK823g9PAVKPI+TbQUMwUdyodrTgllsfOdceo=; b=PaknJv8v/ZyAS6kKsOUau
    fEf81bwczQHRrmkrP2qhS4TR5fRmO6B/IBBqo4xvb9bP8eQxe6SvwB4OuXJ9zCXV
    uI/ut86UO4zKvd4EbaL9TwjRlg5mMtiAb2xvCDLBmHKpXVAiYejTGyOoGWgBQwl6
    m5+YNtyfErGT1JhaGpHi9sHwn8ewBN3o2UV1BXrenhylVf2R9nCMK/zcrsWgQR/m
    iSNfMzlNfvnj3MNSON3tLoLuabHibmjBnJQvqjqmETbEb1HDghnkszxsBzjaZu5F
    iHQAve6TVobuEGXY6hXMx9uAnPFPuP1yXMIsQ95hSv8imrC3xwtmpxkSGDmMeRl/
    w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfELVWuYdj4cCjNYB7Z+ahri5RLWbAJSNqXUdmUTWWN9rRCIvlkCPxrl/0DWGjzrNv+G3I4hpiryzIvi01h/G2CeW4i2y2bOkDSehQDDkeqyEEvcxuaEJ
    CkV+NRNd6NGOekJbhnLi0FzdtXIgcvmxNcHAkEIEa3th7ybVl8p1oK6EfWb5JHUjqWdRMwVBMruouAFph+zHZ3YG3GGZcxfmhQnCLxExuYYnv6nBJf0uwN/D
    4KuDfeupkG93NhQtQCW47w==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=KjG7R9OqOhbJiQy3oYAA:9 a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH 06/76] staging: ks7010: Remove trailing _t from 'struct
 hostif_data_indication_t'.
Date: Fri, 30 Mar 2018 00:07:29 -0700
Message-Id: <20180330070842.25224-6-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:zJS/lNawWaX8n5FQLXtST0X+nWRmDbaAvtYFRq6cwfSEN1/cpfo
 GlHYVXoH0GCmkl0YeDINfw95DI4UNViTXE9YhYcSVb1nw89uWMMJtoSP7SgtmyBHuX6GN4U
 wVttXWtOkRZfetlX6GhxKffHhgYmnUrup3yh9u7IDByThSSQQgBzccSo5KE55hDi3bds87Y
 O7mZbv0FqSQJPwkDcR+ig==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FbWSNMTw88U=:n2TUL9HqzehKG52AxNaCDa
 NL++Wos/wJuQZGliyD67Vu3yY+f25xFxgxdCVwYAamxGoFVCjwqQFBkLT898Cyry/Vw9kT6Ih
 bY90JdVWbq+mTG9JZpBV8mW7ZlGRFUGmP1N5sAWiNdO6A5NlqJbrS1umcywQi0S+fdzUim3fA
 DZeMl+a132JIb3icR8MXx5c1Vh+s/dhK2CZH0mYVwH02dGHscWgcvZAbHpa0VjohpXHie9hFr
 wwuaCpadi7KqFhaMa/E1Wf6xclOpuTMSq4qD0GE+Zco8kKn1J3pzJksG33llPVJdY6/YTyEcO
 4DYnIILzl9l2C7WMO9fr4DwdxUfUUbI+qNWvT6GBgueJ84owil0MI3nsj5xcJVOdkrimG3Rze
 9APw4h5vrXdBc689V7GW6PCyWRZWx9IJMhsbkqqrn8CJzxI3veOnu+jyuSlezwaFOuybPu/Oj
 MwUg6MCCGm5m2zSeCzlyaksIx6jvx/C0eL5e+B88Ma0ir1sIJket7wj1w++vbPUwY6zuvOY/R
 pQR6k25mVVHq3EJh+AdS+R451FxE9xOC738QBdFCuD27dT5+kMSgDRFIX/5zeIsEIxkozkZDR
 /o3p60vebGwJZBXHFtON9y3ax8ud1tVBXSAXRVbK24V6lqVegNo0XXVgwNl36uOZxqKKIvs2G
 sn4wpObw2oHLt2VMyjY8sGom2pTMhdHMAq3IXscs3EMAU0i0vS84J+nrBYMGkamD+lScp/pO5
 f3YvY+ZqGl54hJkIuIc82n3/Sf4tcxsTSpEp2A==
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
all occurences of 'struct hostif_data_indication_t' with 'struct
hostif_data_indication'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 036758687b7f..75c630e1f339 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -76,7 +76,7 @@ struct hostif_data_request {
 	u8 data[0];
 } __packed;
 
-struct hostif_data_indication_t {
+struct hostif_data_indication {
 	struct hostif_hdr header;
 	__le16 auth_type;
 /* #define TYPE_DATA 0x0000 */
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
