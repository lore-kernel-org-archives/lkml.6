Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B738EC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B50F2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:16:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B50F2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=triplefau.lt
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbeILNTw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 09:19:52 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:54631 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeILNTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 09:19:51 -0400
X-Greylist: delayed 43331 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Sep 2018 09:19:50 EDT
Received: from sogo2.bi1.0x35.net (sogo2.bi1.0x35.net [10.150.1.72])
        (Authenticated sender: repk@triplefau.lt)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPA id 45C3424000D;
        Wed, 12 Sep 2018 08:16:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
In-Reply-To: <20180911184755.GA2562@kroah.com>
From:   "Remi Pommarel" <repk@triplefau.lt>
X-Forward: 62.23.167.188, 10.150.1.6
Date:   Wed, 12 Sep 2018 10:16:22 +0200
Cc:     "Jiri Slaby" <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        "Kees Cook" <keescook@chromium.org>,
        "Elie Roudninski" <xademax@gmail.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
MIME-Version: 1.0
Message-ID: <3459-5b98cb80-1-49ed5900@198591000>
Subject: =?utf-8?q?Re=3A?==?utf-8?q?_=5BRFC?= PATCH =?utf-8?q?0=2F4=5D?= Add 
 specific vt input's key map
User-Agent: SOGoMail 3.2.10
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 
On Tue, Sep 11, 2018 at 08:47:55PM +0200, Greg Kroah-Hartman wrote:  
> 
> Normally I do not review "RFC" patches as it implies the submitter does
> not think they are a valid solution.  How about resending them as if you
> think this is something ready to be merged?

I had used "RFC" here because I had one or two questions about the
implementation choices I made on those patches and not really on the
solution itself. So, yes, I don't mind sending another round of those
patches without RFC.

Thanks,

-- 
Remi

