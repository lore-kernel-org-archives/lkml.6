Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752014AbeBWALJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 19:11:09 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:43475 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751553AbeBWALI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 19:11:08 -0500
X-ME-Sender: <xms:G1yPWgKoNKWXC3OqdYp-fO0BrSvw74hxpu9ztg5D1NbuF4eWQ9tTMQ>
Message-Id: <1519344667.1024159.1280347184.36AD3FEC@webmail.messagingengine.com>
From: Andrew Jeffery <andrew@aj.id.au>
To: "Wang, Haiyue" <haiyue.wang@linux.intel.com>,
        Joel Stanley <joel@jms.id.au>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: MessagingEngine.com Webmail Interface - ajax-efbb3405
Date: Fri, 23 Feb 2018 10:41:07 +1030
References: <20180222050324.21531-1-joel@jms.id.au>
 <1519288786.101739.1279390200.1CD3EC51@webmail.messagingengine.com>
 <23b668f1-ab4b-7ef3-ba1e-f252fbba4d1b@linux.intel.com>
Subject: Re: [PATCH] MAINTAINERS: Update ASPEED entry with details
In-Reply-To: <23b668f1-ab4b-7ef3-ba1e-f252fbba4d1b@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1N0BHfP029867

Hi Haiyue,

On Thu, 22 Feb 2018, at 19:20, Wang, Haiyue wrote:
> Dear Andrew & Joel,
> 
> Since you are ASPEED BMC experts, any time and interest in eSPI code 
> review ? I've sent
> 
> it before, but no more response. Intel recommends eSPI bus than LPC as I 
> know. I just kept
> 
> the minimal eSPI code which is approved to work well in our real server 
> boards for two more
> 
> years. Other part of eSPI driver from ASPEED's SDK  has been removed, 
> because ePSI is a new
> 
> thing, we only use a small feature set like booting host.
> 
> We Intel submit this eSPI patch for openbmc upstreaming, hope for your 
> response. :-)
> 
> https://patchwork.kernel.org/patch/10166577/
> 

There are some comments against the v1 that you linked to above, is there a v2 on the lists?

Separately it's better to ping us by replying to the patch itself and putting us in To/Cc, that way we keep discussions focused on the patch at hand here.

Cheers,

Andrew
