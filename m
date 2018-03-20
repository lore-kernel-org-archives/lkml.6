Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-180677-1521512877-2-1392155162832135690
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES ensv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521512876; b=KNH3SXZDCHMPlo6BByB1kDcXjp4SwMRxgNkVgEkt3NygpPS
    N4k97PNZDPwicbUv+laGT43d3uPyIWBEk73W7RN0izRlyjlWtkO5XXiB1TfRZU+f
    2x1/y3E5B6zxJfsQbDQVyczjD0KcRoqI9BQM8dQGwyW9Ms8A6/ngecwnqWMJUY1K
    Ymo3uhO5Rm+93yhLi2Q/HIEnGi97mTTuxpUPAAuFX5dgKYfemoOFiIuwcRHiZERw
    Q2ZUka5M97QM0FMRnGN/4Ef4VjBnHbklULo8vKD8mB3vJ9Fgbhx+hG7cHgo4EsK1
    JForDI5BcnF6v4szQezvbNDNsHyKBEl1qxt8NVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1521512876; bh=3fEEIVOk4p7RaBKDgh/L5x01Za
    vNSQoOhdTH1qORlCM=; b=G9ifupEDyIhdZzJvDkHq3O6T5Oiq0wch7CCH6ghvqx
    QeqGiqpF3JSgubCvl1n+47m+RBg60OztegCcvqbE8aHYBx5kErsiSVMzr/2eFGv1
    MFoeEAiNU/D01I3dZ19HhvkM6q6rIGqC/YrHb/UQSVd2Imnba1Kv5p/vWw/cTnN5
    ytGnhVGTpnK0sHJyRYqQSlZXs0yBPUe2jVSedne4PCPGnuBw3xtdG0vn5JcMdNKd
    UehzPgRUC154CJYsR82BLew/cZv3RCum/MQWjkEMNNMuou69YY7Dwdg2nwLpweZd
    y63oJOZ7phPk3LFsp0DBM0pC9JZIHvGwB9LJUFGtEvBg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=gmx.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmx.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudeggdegjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffoshhpjeestddtredtredttdenucfhrhhomhepjfgvihhnrhhitghhucfutghhuhgthhgrrhguthcuoeighihprhhonhdrghhlphhksehgmhigrdguvgeqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdeivddrudegfedrvdeggedrvddvkeenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeolhhinhhugidquhhssgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepfeeivdeknecuvehluhhsthgvrhfuihiivgeptd
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=gmx.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmx.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudeggdegjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffoshhpjeestddtredtredttdenucfhrhhomhepjfgvihhnrhhitghhucfutghhuhgthhgrrhguthcuoeighihprhhonhdrghhlphhksehgmhigrdguvgeqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdeivddrudegfedrvdeggedrvddvkeenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeolhhinhhugidquhhssgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepfeeivdeknecuvehluhhsthgvrhfuihiivgeptd
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751511AbeCTC1v (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 22:27:51 -0400
Received: from mout.gmx.net ([212.227.17.22]:52785 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750969AbeCTC1p (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Mon, 19 Mar 2018 22:27:45 -0400
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Bin Liu <b-liu@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v2 1/1] usb: musb: gadget: misplaced out of bounds check
Date: Tue, 20 Mar 2018 03:27:35 +0100
Message-Id: <20180320022735.4548-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.16.2
X-Provags-ID: V03:K0:Qyv3tT/QZe3pONhIgWVOXoPU3dHDKyr9/31UVeHfbiL4eF9DaSz
 8Dbi92CBNNBPT3CNH4F+GVI/lsc+7j55mZ9l+V40SnYSMEfVdvKAnSONWPHM6/D1k9F3URa
 LXp2wkmA2QObhPOZ0eXRiOJPpqJ5ghJ+EQTN+qAC64vcXipSe6CPx+80NCsmUPPEziP7vSK
 LZQSciUkMCG1tfPlGWpIg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QW6gnU+FcFU=:SJdMqaA16dwRQAAIcjRkjV
 bGCQDUHcP9fVBF78pXpBbLKLZQYdq2YtICToF/TJEUPBM39/Q4rFEqm+MC5qx1j9cEkuTs7HB
 7wp3RNW3VrkhfD96jJMgB0OiHi/5HZpYVxt1AkyQF7sIjrKCNTOXvOycXlfR5RCoj6YsapDq9
 pH4xaQJd5Ypi4jZNA8/bdO5dUEio7VWqC3ePErVs/MpFDvjRTKG7vhNTV/D49eL29kMdkpLnW
 054TUO3gx4zAZIV0I+aQI2pbZjwH18afRi/vgrHgKwr94WMp/r+tGBsqkjZlWC/Jem2wm4rVj
 zixtSs1TVCW7n8gq5wOr67PuEUU8TmSq2+jMGiGGUE+1YPfM9BR4MR4G5pLJ85gFDnUdyF81a
 w9G1MoDmhafDQeaEhw5Gf9XC6SuQzaVaKf2h0YALXp8Pypo2npZW16q3BZ8UgpeMXZlRDpgo6
 zkyjxCcejTKGJk2F+e3f/pvlQ/T4S0z9iM+VaH8NLH3BuSkFHlROsgVdsTWRIIfQ3iog7lerI
 DWqAqCZ8dL3v+WNrKDqZDa58JSCO+9VsxXRqaOTHR2QSKuxPNzcP4dytSAgx9/NPLDGO6YecF
 8m2p+iJapqNP0myu8AobkdT228KPZ8yZkA5+94dcRHhlVV/BM+C7q3lyvw3q/wbsCyPIdqfDk
 BC0ZUnh9KeJVWNxlS5EgKV0FmVD0pRxI4f8ZgVQ4z+W/vxQ3hbB6sz7N2bzkQEsskZ0YaQ8J7
 GvrR2S4qX+CZTMLFQ/mu8r7vEhjFeMUNmDiUy8a1YabeQQ0bWsV3uoeRsa/6HyZUyNflAXyu1
 uQEC6WaG8frTGlJasiVagw+KYgmaw==
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

musb->endpoints[] has array size MUSB_C_NUM_EPS.
We must check array bounds before accessing the array and not afterwards.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
v2
	Only the 4 low bits of epnum are relevant for indexing.	
---
 drivers/usb/musb/musb_gadget_ep0.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/musb_gadget_ep0.c b/drivers/usb/musb/musb_gadget_ep0.c
index 18da4873e52e..96b0fa12f729 100644
--- a/drivers/usb/musb/musb_gadget_ep0.c
+++ b/drivers/usb/musb/musb_gadget_ep0.c
@@ -89,15 +89,20 @@ static int service_tx_status_request(
 		}
 
 		is_in = epnum & USB_DIR_IN;
+		epnum &= 0x0f;
+		if (epnum >= MUSB_C_NUM_EPS) {
+			handled = -EINVAL;
+			break;
+		}
+
 		if (is_in) {
-			epnum &= 0x0f;
 			ep = &musb->endpoints[epnum].ep_in;
 		} else {
 			ep = &musb->endpoints[epnum].ep_out;
 		}
 		regs = musb->endpoints[epnum].regs;
 
-		if (epnum >= MUSB_C_NUM_EPS || !ep->desc) {
+		if (!ep->desc) {
 			handled = -EINVAL;
 			break;
 		}
-- 
2.16.2

