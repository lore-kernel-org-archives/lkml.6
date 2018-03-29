Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4151933-1522302742-8-8687527192888452726
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522302740; b=TZO2JESGExha/P2Mu7jhAC8l1gZ/85mg3Yxm6eHiTVZPVxQ
    SG9FJe0lFPxXf+ikqXVlZgqmJ1HOWj3bz8MsD+BmfMluhKRlsscDRs6Qd1TlLkwW
    2c6J3nfObvZRv2yEHnlmjazvSijlMizx7Ys4RtEspqtfkN+hp7RBGH7TiMGHI+Y+
    bDWzsWCnTh43+WXmNTQi34d8vm+GMpzBMIvb6q45k2TkL+iu7NWqlhDSM6+ZGsCJ
    eUaQdZXP+h7QGkRI0GtvhBOeCwJn6MINR4mH9DpALcl9Js3h5v8KduWQSWNo8ORz
    FBLb/FXW/lV3zJmhe2x2EByWhcH2g0MeWN8fmIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1522302740; bh=x
    VjnIxqWkkipKZEmbXscMmKdEJmG6dQL0LFG2EWqk5c=; b=vxgMkcB6z9Suj8LDg
    t7EfuZoUGhQMq1AgefcqvVxbGtj4UNWfngRliUB8Pan2BrJEWUWgsbMmIXIm8yf+
    +yrJ51HWKIyq9a9nP2qOuj4mAORSv8iCx7MFDW98pc4r6yePSh0QUeK8m28y7CAE
    Q8ozzYSW9VsyF6HQBP+w9Mg/rj3ctqBBlTOccJQPuHmWj99YgoG8iQGdp9uF5gNi
    eytYlkpsspwZQ7ZtMn/BDV8W9R0ldduSinwUySYZ6S8NW6WoTYKmFVkApFVA9Grp
    B42iALsH9NYWf7Tpl30nMrgc+v3EDWMPyZuUjiRrnEeanAOHvXcl04lpTXlkMnp0
    NXelA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfGHN+OGq+XeAndDNBhfTJaWAiU2JWNXXjIym+WKbD3CJ4FV0b54HJhVgk47CQDLw7n2p1cK6VfyBWTnjhlNz1VEt2iva0H4kpgQxTtgUJ+QnsoRga2IE
    8TAmucRy51o19AJf/a7Feo7Xv9b0sjMqLym6O9fEZ0FptYP9y0IOqdbabifmI67lKoFlHI+EDIj5SNrCn2ANjg8DqT5zvpuWhP1SEBerDlzwBIVhj2vjBcKK
    szwKwzqhy616+2bCeCpHNA==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=FouRZXctK3f4kjtw80UA:9 a=xZTfmAK6p-a7gq16:21 a=dWuOuzNvHEhcC6Xq:21
    a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH 3/9] staging: ks7010: Reorder ks_wlan_netdev_ops members.
Date: Wed, 28 Mar 2018 22:51:46 -0700
Message-Id: <20180329055152.13059-3-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329055152.13059-1-quytelda@tamalin.org>
References: <20180329055152.13059-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:8NAPY88vj/HDZ/lUOHSvcnFoWAm8qvIcTdlNpbr2QYrw4/eMqf/
 VYz+hKmRfDKjRPWnkg8T7MtAqOWbm4bPMCLovWYbi+EHK9vQ/l0XYLfT2ondBPMCDFZVN3X
 Pi2UuVPysX60tw+fo+XhG0faq1hYroh65rSa6GtUjXazG3K/DYYNG133jIzmzyZTXe+xEJg
 al021tSQhd7Vd38b1jXXg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:h2nAqg9QELk=:YKuxB+ksZg0NTCXQ07brU6
 BqXaNgKcssY04yD0X4ln6RV/iKsBHUoE1goBV8x1InxUblLyZNgE5zvj/3MmDmn75xr/vEFV3
 V2pdsyvx+wU36UPVDWBfx8GgdF9TRGseT7RWokP+6OzxuPXA42W7cswZgLIflHhX1wbz73zPi
 avNG0Mqa+DHU7UomzjsUVYY/NBM1n+bnPuuF53zqTAHh0IJG5YFBF8zdL1oMx7++ItYbpq8at
 15NUcbsJ+Wsh4ICBXT9gqo2ARZwnc0XHSitE2RylhhtI80i9saz943uvVJF7xvhqdeT8lskk9
 7hnN+QQ9d4I829BtI7uv+v+/IPkpTz0yvklv3WtBb4sPKGXVc4nZ4oVPM+VCcuzyOFMrvA2sA
 ELIXeecit+HSz09UHuUmS+QuJ71ClfyhTO4krDHXCh0+KwPtIU5sJYY8b1QiP5KELXJJqL+Yy
 69ePEOSfAVKmK9NQzHaNsT/1X0DWBb8Jre5kMykRVNbhuCYepNUcX45t6/v9Hnzq1LD0sMII5
 DgTJ8wXM5Ax5n3eZW4Qcx+THC5kJ73eAdP15f8ri1jy0lhloZG4UBncat+332TpDLiwc9uPwM
 8sn3nqz9yNo8egIihejyq4KbTu5bIbNFE/vlR4Zyf83eBmDpczqHflny9an7fiPt4sjJprh/n
 TPVRkTRijo6hq3arDwozwg72fd+rs+Snr8g5gxHxhOULI/HWweTKHLh/r8RA6ra9QOMbh1tnd
 CO/5FCOtBvziZfKU/vwmwmtSSSZCKMztGjf9zg==
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

Reorder the members of 'ks_wlan_netdev_ops' to reflect the order
of their counterparts in the kernel's 'struct net_device_ops'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_wlan_net.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/ks7010/ks_wlan_net.c b/drivers/staging/ks7010/ks_wlan_net.c
index 544bfa403d9f..2f84c5dc1324 100644
--- a/drivers/staging/ks7010/ks_wlan_net.c
+++ b/drivers/staging/ks7010/ks_wlan_net.c
@@ -70,14 +70,14 @@ static const struct iw_handler_def ks_wlan_handler_def;
  *	function prototypes
  */
 static int ks_wlan_open(struct net_device *dev);
-static void ks_wlan_tx_timeout(struct net_device *dev);
-static int ks_wlan_start_xmit(struct sk_buff *skb, struct net_device *dev);
 static int ks_wlan_close(struct net_device *dev);
+static int ks_wlan_start_xmit(struct sk_buff *skb, struct net_device *dev);
 static void ks_wlan_set_multicast_list(struct net_device *dev);
-static struct net_device_stats *ks_wlan_get_stats(struct net_device *dev);
 static int ks_wlan_set_mac_address(struct net_device *dev, void *addr);
 static int ks_wlan_netdev_ioctl(struct net_device *dev, struct ifreq *rq,
 				int cmd);
+static void ks_wlan_tx_timeout(struct net_device *dev);
+static struct net_device_stats *ks_wlan_get_stats(struct net_device *dev);
 
 static atomic_t update_phyinfo;
 static struct timer_list update_phyinfo_timer;
@@ -2874,14 +2874,14 @@ static const unsigned char dummy_addr[] = {
 };
 
 static const struct net_device_ops ks_wlan_netdev_ops = {
-	.ndo_start_xmit = ks_wlan_start_xmit,
 	.ndo_open = ks_wlan_open,
 	.ndo_stop = ks_wlan_close,
-	.ndo_do_ioctl = ks_wlan_netdev_ioctl,
+	.ndo_start_xmit = ks_wlan_start_xmit,
+	.ndo_set_rx_mode = ks_wlan_set_multicast_list,
 	.ndo_set_mac_address = ks_wlan_set_mac_address,
-	.ndo_get_stats = ks_wlan_get_stats,
+	.ndo_do_ioctl = ks_wlan_netdev_ioctl,
 	.ndo_tx_timeout = ks_wlan_tx_timeout,
-	.ndo_set_rx_mode = ks_wlan_set_multicast_list,
+	.ndo_get_stats = ks_wlan_get_stats,
 };
 
 int ks_wlan_net_start(struct net_device *dev)
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
