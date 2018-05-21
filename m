Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1344077-1526937781-2-571671138782450018
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enroda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526937780; b=GODowbf2zf3fk3yb1D070xkuZZWhpZfGQfN2mgRVMfs7oYqTWi
    lcCTX/iar+GBXbrJtNFLW3JfVrUXVWhX67iXjDNsNkpanucpSRJzY7vaPA0YkNSF
    SDhhJJV4aU9z7k/mHyvR006CwycBMdS4+J7+GqC76dPmqjnslKkQRMtsahfi/KtH
    fVAzMhJ7W8ZHWpGpzqRLdql6NZHQwCIva8p0wIfgjwh0ytTSQ5H5nQOR1nEgD/RJ
    1DUqhmA2Y94E4qt1qxrrkCforeZpZxeoUBH+WD9uCdD6jNPsR0YkFu87CiIKEWoF
    LMWhvOHxk5HbWj/dP7G8XS7sfAC9+63jlQgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526937780; bh=r0FqWwRt8/I6VFfX02r7TwDSAC7O0n
    FnhTJWMJzPmuY=; b=Sliekh60kzT6jP6w3Cux9ezK+gyMueucx8JcpXpiVTJWEj
    gquXxL9MBfRyPSjFelAYV5fvW9hz6ClD0OhgKhK9E9EVqxtIKBGgfxGhDVBP5Kq3
    mlFHW1V+xLQ1UdijOlBdLghUNN5VBX1f2XnX/G6LRbGIlR0KIeCm9vmjsI7VBZfC
    7FwEir3Mqv8VS+oImtOrLQtoruWvk4rCaTZduqjW05mLnFHUDrG9YX6xCgXR75pQ
    GtpPBl86p8VatVrS/ZvliI5KHl6GZl3sOu4srDWXk+V79cZ/VZKTdvRki5KspG/E
    XFsWjBRj9Tvb/3pOsSLRdlgSCZYrV0IsmB8fORJw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=E7OFPHJ6 x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=E7OFPHJ6 x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH3vv8ZDUjW5ls0qVRfCwY7TXqVo/bPMD6hRB0Fi6rjoIbY7LQfXjZslyt6Iqaz77B14KfDTNIv+AGtQn9Xp1hO61eX6YRzjm0LqkexuVDEScqa+R/Kg
    lowPbCKBmfOnY2t/x5oVUdiS1WkLTTqvGiZJbLCXqkOVymVkQTD+uP2ecO2t6Gmj4d3galIVq23X1BknRE1i0J1exLBuYwHhoDBmL3vkcuuxIUEuTS3L8oPj
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=hD80L64hAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=KslZaVS1h0vLkMwhe8wA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754316AbeEUVWz (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:22:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:37730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754305AbeEUVWv (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:22:51 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 4.16 002/110] usbip: usbip_host: refine probe and disconnect debug msgs to be useful
Date: Mon, 21 May 2018 23:10:59 +0200
Message-Id: <20180521210504.023378330@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shuah Khan <shuahkh@osg.samsung.com>

commit 28b68acc4a88dcf91fd1dcf2577371dc9bf574cc upstream.

Refine probe and disconnect debug msgs to be useful and say what is
in progress.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/usbip/stub_dev.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/usb/usbip/stub_dev.c
+++ b/drivers/usb/usbip/stub_dev.c
@@ -302,7 +302,7 @@ static int stub_probe(struct usb_device
 	struct bus_id_priv *busid_priv;
 	int rc;
 
-	dev_dbg(&udev->dev, "Enter\n");
+	dev_dbg(&udev->dev, "Enter probe\n");
 
 	/* check we should claim or not by busid_table */
 	busid_priv = get_busid_priv(udev_busid);
@@ -404,7 +404,7 @@ static void stub_disconnect(struct usb_d
 	struct bus_id_priv *busid_priv;
 	int rc;
 
-	dev_dbg(&udev->dev, "Enter\n");
+	dev_dbg(&udev->dev, "Enter disconnect\n");
 
 	busid_priv = get_busid_priv(udev_busid);
 	if (!busid_priv) {
