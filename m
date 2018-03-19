Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3490358-1521484891-2-15421231040940939380
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES roenca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521484891; b=YBHebU1yRjYHIrBeM6I3fn6Y7UtLGs0XZXleSdCsymLNpDe
    3oIB7fTt6AwZRJQWHzMB/MPgpFN4STugp4v122b2U7WUhc7RRad9J3HC2MiQcHcV
    Xmmw8E7mrdxUDw2diJjmY5nY6TQKU6gOzjVtdLbyFJBTDCmmWSa5BYtOgneEaw5r
    S3A+irbfyI7TROFsPXMS3LgaQwvnc4lAdX7+N4FNXs/5xh34j5vQETKuoWipB59v
    131iWiZrn4b07yTyXxmdrI0JGoeYUk2U2JJfNYvcRIc/LOrW9CGLaoj+58zoK4Tg
    Mae6c2BsR+NxuWIrm4Y42ylk0AJmwhMC469/UFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521484891; bh=oYAvJwUDA/h7Hm4HxdEFfSfSqj
    xiX3JXJFNzQ3x6aLY=; b=mi+ILhFDmNT+WtOVpJru9euUBkbDzL/9w5UM5hF2y1
    ngMTDWWVFRpKZTfNPupk5kLtRBpOA3JCvpzeatw956bEWQyUgTtcdK4EUzKaqAm0
    ja/BJh+7eGS0mbG5TSMQENKNUDnz9hHzrv72RAkYHul20y6Wz/01HUj92s9+jeUO
    +sJwIF1tu/lzf9MZQLpqgVB0XTYkyVMZgim8szrrVinmqFXfndAiQzeRcRjmPIxg
    LJlyfmnj1y9nYh7GRD21i7M60Tpm0vhNa1qryQ0sVzUmJJ0cCZC0050Df8guYS3e
    4TYC0n17XgAUpsE/8e8xROBLuDTmQpaM4pJkXsozxUbw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeiieelfeenucevlhhushhtvghrufhiiigvpedutd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeiieelfeenucevlhhushhtvghrufhiiigvpedutd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032181AbeCSSlH (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:41:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54088 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S970218AbeCSScv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:32:51 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roger Quadros <rogerq@ti.com>,
        Manu Gautam <mgautam@codeaurora.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.15 46/52] usb: dwc3: core: Power-off core/PHYs on system_suspend in host mode
Date: Mon, 19 Mar 2018 19:08:44 +0100
Message-Id: <20180319180737.522895594@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180734.976730813@linuxfoundation.org>
References: <20180319180734.976730813@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Manu Gautam <mgautam@codeaurora.org>

commit c4a5153e87fdf6805f63ff57556260e2554155a5 upstream.

Commit 689bf72c6e0d ("usb: dwc3: Don't reinitialize core during
host bus-suspend/resume") updated suspend/resume routines to not
power_off and reinit PHYs/core for host mode.
It broke platforms that rely on DWC3 core to power_off PHYs to
enter low power state on system suspend.

Perform dwc3_core_exit/init only during host mode system_suspend/
resume to addresses power regression from above mentioned patch
and also allow USB session to stay connected across
runtime_suspend/resume in host mode. While at it also replace
existing checks for HOST only dr_mode with current_dr_role to
have similar core driver behavior for both Host-only and DRD+Host
configurations.

Fixes: 689bf72c6e0d ("usb: dwc3: Don't reinitialize core during host bus-suspend/resume")
Reviewed-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/dwc3/core.c |   36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -100,6 +100,8 @@ static void dwc3_set_prtcap(struct dwc3
 	reg &= ~(DWC3_GCTL_PRTCAPDIR(DWC3_GCTL_PRTCAP_OTG));
 	reg |= DWC3_GCTL_PRTCAPDIR(mode);
 	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
+
+	dwc->current_dr_role = mode;
 }
 
 static void __dwc3_set_mode(struct work_struct *work)
@@ -133,8 +135,6 @@ static void __dwc3_set_mode(struct work_
 
 	dwc3_set_prtcap(dwc, dwc->desired_dr_role);
 
-	dwc->current_dr_role = dwc->desired_dr_role;
-
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	switch (dwc->desired_dr_role) {
@@ -218,7 +218,7 @@ static int dwc3_core_soft_reset(struct d
 	 * XHCI driver will reset the host block. If dwc3 was configured for
 	 * host-only mode, then we can return early.
 	 */
-	if (dwc->dr_mode == USB_DR_MODE_HOST)
+	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_HOST)
 		return 0;
 
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
@@ -915,7 +915,6 @@ static int dwc3_core_init_mode(struct dw
 
 	switch (dwc->dr_mode) {
 	case USB_DR_MODE_PERIPHERAL:
-		dwc->current_dr_role = DWC3_GCTL_PRTCAP_DEVICE;
 		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE);
 
 		if (dwc->usb2_phy)
@@ -931,7 +930,6 @@ static int dwc3_core_init_mode(struct dw
 		}
 		break;
 	case USB_DR_MODE_HOST:
-		dwc->current_dr_role = DWC3_GCTL_PRTCAP_HOST;
 		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST);
 
 		if (dwc->usb2_phy)
@@ -1279,7 +1277,7 @@ static int dwc3_remove(struct platform_d
 }
 
 #ifdef CONFIG_PM
-static int dwc3_suspend_common(struct dwc3 *dwc)
+static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 {
 	unsigned long	flags;
 
@@ -1291,6 +1289,10 @@ static int dwc3_suspend_common(struct dw
 		dwc3_core_exit(dwc);
 		break;
 	case DWC3_GCTL_PRTCAP_HOST:
+		/* do nothing during host runtime_suspend */
+		if (!PMSG_IS_AUTO(msg))
+			dwc3_core_exit(dwc);
+		break;
 	default:
 		/* do nothing */
 		break;
@@ -1299,7 +1301,7 @@ static int dwc3_suspend_common(struct dw
 	return 0;
 }
 
-static int dwc3_resume_common(struct dwc3 *dwc)
+static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 {
 	unsigned long	flags;
 	int		ret;
@@ -1315,6 +1317,13 @@ static int dwc3_resume_common(struct dwc
 		spin_unlock_irqrestore(&dwc->lock, flags);
 		break;
 	case DWC3_GCTL_PRTCAP_HOST:
+		/* nothing to do on host runtime_resume */
+		if (!PMSG_IS_AUTO(msg)) {
+			ret = dwc3_core_init(dwc);
+			if (ret)
+				return ret;
+		}
+		break;
 	default:
 		/* do nothing */
 		break;
@@ -1326,12 +1335,11 @@ static int dwc3_resume_common(struct dwc
 static int dwc3_runtime_checks(struct dwc3 *dwc)
 {
 	switch (dwc->current_dr_role) {
-	case USB_DR_MODE_PERIPHERAL:
-	case USB_DR_MODE_OTG:
+	case DWC3_GCTL_PRTCAP_DEVICE:
 		if (dwc->connected)
 			return -EBUSY;
 		break;
-	case USB_DR_MODE_HOST:
+	case DWC3_GCTL_PRTCAP_HOST:
 	default:
 		/* do nothing */
 		break;
@@ -1348,7 +1356,7 @@ static int dwc3_runtime_suspend(struct d
 	if (dwc3_runtime_checks(dwc))
 		return -EBUSY;
 
-	ret = dwc3_suspend_common(dwc);
+	ret = dwc3_suspend_common(dwc, PMSG_AUTO_SUSPEND);
 	if (ret)
 		return ret;
 
@@ -1364,7 +1372,7 @@ static int dwc3_runtime_resume(struct de
 
 	device_init_wakeup(dev, false);
 
-	ret = dwc3_resume_common(dwc);
+	ret = dwc3_resume_common(dwc, PMSG_AUTO_RESUME);
 	if (ret)
 		return ret;
 
@@ -1411,7 +1419,7 @@ static int dwc3_suspend(struct device *d
 	struct dwc3	*dwc = dev_get_drvdata(dev);
 	int		ret;
 
-	ret = dwc3_suspend_common(dwc);
+	ret = dwc3_suspend_common(dwc, PMSG_SUSPEND);
 	if (ret)
 		return ret;
 
@@ -1427,7 +1435,7 @@ static int dwc3_resume(struct device *de
 
 	pinctrl_pm_select_default_state(dev);
 
-	ret = dwc3_resume_common(dwc);
+	ret = dwc3_resume_common(dwc, PMSG_RESUME);
 	if (ret)
 		return ret;
 
