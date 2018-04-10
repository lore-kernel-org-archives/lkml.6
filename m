Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2325483-1523319391-2-9537000635617371176
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523319391; b=QgNktv/Dw1Vkf6w7yTolmbTwbpmxSvxZIDJGOgNZKFRgNp2wUX
    m8A91log4/dPqnuwe+6uabC3uOJXwnVrPftaMdynS++/ihKV8DrDh3z5+Hlo05e4
    d7ro1Gbl+5MARhduMWoGAMxTYD4yVQWrg1AqmWhn+JjLYFT+7JVQSAG04vy+bJ5S
    qct8/Wr1swTBMNlWqzvhPLZxLcXbgq+a/9s72IIye/CHt/0z2eF3r3/BblcjJY2K
    fMk6LO6uWnaEDORuIDJa/gxCT45xZP944P9tx62oJk4WpAgZ+X3//rroDA7+7uVY
    2Z2jgK4se9Aqvu0KiOBhgakBcUz8W5l3VJFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1523319391;
    bh=Qdc2Do3jI0Q8IQPFMApByjgFdB+P7rBVw7jTcmBBhW0=; b=QP+laAgdSrA8
    xZqO7Wv5/EGoiQTATZ5CiVTbfKlFkYl215ScCY3+pZL569cbYwLtsovKlsaJ7YHz
    hlPM2fn3UpIh7bL/s0TUJDI9VEcfK02GjwkhUTH/OJHQ6DinGQZM3UnX6W6u+kg6
    N0TrNpgLHWAn7WXPxLb+PLOXzmFp94R50gMb7JwNrd8RMfBdog2E3RI/MnPLWAly
    jiAc6R3CZaIKcNE5Yrey27Y/W8MN960h1ZivRGaBsxjdhcj20t5CQfIiVQ/DwJ9H
    wD746To8CK2musqEqmMYSrSeZUFlReFwzbiKIpKNgIBpc/fG0d8J9JT9bIoHh2CW
    7cd4OoHZTg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=ziemianowicz.com header.i=marcin@ziemianowicz.com header.b=fQXQ51I6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=somekey;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ziemianowicz.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ziemianowicz.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=ziemianowicz.com header.i=marcin@ziemianowicz.com header.b=fQXQ51I6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=somekey;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ziemianowicz.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ziemianowicz.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfG+cLOJbw5lVJn58tV02XD+AeZA6LJCEJBOmBWfb9VbjIcpRSkFVQYBfwQyuNfHlzSaI2D5vlL14jnAYMQHbxShDgT3i79BPBnWb9ToMhzQ3QDYE56td
    aDovYvU9gNhHmnpYFL39kbi6JMMGqtwPvCUsGvGXnVAjr3db+Jopf9Lr2NFxQiuqjfieIcLTDSZCKhvjmf49sv3jmZsXsrYtG3K3jXOKBjJi4pY/tUW8MWqw
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=0AA9OZvs-ncA:10 a=VwQbUJbxAAAA:8 a=RPNnV_h2TRwK2Bn0seEA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751643AbeDJAQR (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 20:16:17 -0400
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21329 "EHLO
        sender-of-o52.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751367AbeDJAQP (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 9 Apr 2018 20:16:15 -0400
Date: Mon, 9 Apr 2018 20:15:51 -0400
From: Marcin Ziemianowicz <marcin@ziemianowicz.com>
To: Boris Brezillon <boris.brezillon@free-electrons.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH v2 0/2] clk: at91: Added more information logging
Message-ID: <20180410001551.GA62208@hak8or>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ZohoMailClient: External
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is a series of patches which resolves set_rate() for the PLL not
having any effect and therefore the USB Host port not working. Also, a
few messages were added which may be helpful in the future when others
are working with USB clocking.

Changes since V1:
  Added patch set cover letter
  Shortened lines which were over >80 characters long
  > Comment by Greg Kroah-Hartman about "from" field in email addressed
  > Comment by Alan Stern about redundant debug lines addressed

hak8or (2):
  clk: at91: Added more information logging.
  clk: at91: Fix for PLL set_rate changes not being actually written to
    PLL peripheral bits

 drivers/clk/at91/clk-pll.c   | 14 +++++++++++++-
 drivers/clk/at91/clk-usb.c   | 10 ++++++++--
 drivers/usb/host/ohci-at91.c | 16 ++++++++++------
 3 files changed, 31 insertions(+), 9 deletions(-)

-- 
2.17.0


