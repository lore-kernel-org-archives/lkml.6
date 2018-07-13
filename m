Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6536BECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E746520873
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E746520873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=darmarit.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbeGMJZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 05:25:17 -0400
Received: from smtp3-1.goneo.de ([85.220.129.38]:34778 "EHLO smtp3-1.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbeGMJZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 05:25:16 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Jul 2018 05:25:15 EDT
Received: from localhost (localhost [127.0.0.1])
        by smtp3.goneo.de (Postfix) with ESMTP id 8CD1F23F3CC;
        Fri, 13 Jul 2018 11:04:49 +0200 (CEST)
X-Virus-Scanned: by goneo
Received: from smtp3.goneo.de ([127.0.0.1])
        by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KCKOS2fnah-Y; Fri, 13 Jul 2018 11:04:48 +0200 (CEST)
Received: from ryzen (dyndsl-091-096-214-158.ewe-ip-backbone.de [91.96.214.158])
        by smtp3.goneo.de (Postfix) with ESMTPSA id DB39223F11C;
        Fri, 13 Jul 2018 11:04:47 +0200 (CEST)
Message-ID: <9bc6b8f18ee22d9e7aa053a1167a3830a4e8f401.camel@darmarit.de>
Subject: FYI: [PATCH net-next 2/2] docs: networking: Fix failover build
 warnings
From:   Markus Heiser <markus.heiser@darmarit.de>
To:     "Tobin C. Harding" <me@tobin.cc>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Sridhar Samudrala <sridhar.samudrala@intel.com>,
        linux-doc@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Date:   Fri, 13 Jul 2018 11:04:47 +0200
In-Reply-To: <20180711214250.19039-3-me@tobin.cc>
References: <20180711214250.19039-1-me@tobin.cc>
         <20180711214250.19039-3-me@tobin.cc>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hy Tobin, 

> Add '::' before code snippets and indent all snippets uniformly starting
> with 2 spaces.

Just FYI about reST Markup (no need to fix anything in your patch).

You can also add '::' (the markup for literal blocks) at the last line of the
previous paragraph, e.g:

<snip>--- 
Booting a VM with the above configuration will result in the following 3
netdevs created in the VM.::

  4: ens10: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP
group default qlen 1000
      link/ether 52:54:00:00:12:53 brd ff:ff:ff:ff:ff:ff
<snap>---

IMO its more readable in plain text. Anyway it is not wrong to add '::' in a
separated new line ... and thanks for your patch.

If you have any doubt about reST markup, I recommend the primer from the Sphinx
project:

  http://www.sphinx-doc.org/en/stable/rest.html

and the quickref from the (underlying) docutils project:

  http://docutils.sourceforge.net/docs/user/rst/quickref.html

-- Markus --

