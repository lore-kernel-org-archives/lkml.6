Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752366AbeEGMip (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 08:38:45 -0400
Received: from s3.sipsolutions.net ([144.76.63.242]:35842 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751891AbeEGMim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 08:38:42 -0400
Message-ID: <1525696706.6049.7.camel@sipsolutions.net>
Subject: Re: [PATCH 09/18] net: mac80211.h: fix a bad comment line
From: Johannes Berg <johannes@sipsolutions.net>
To: Kalle Valo <kvalo@codeaurora.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Date: Mon, 07 May 2018 14:38:26 +0200
In-Reply-To: <87fu334p5v.fsf@purkki.adurom.net>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
         <cover.1525684985.git.mchehab+samsung@kernel.org>
         <1b14ef4f63547c86c544e112b74acfff2b41f4af.1525684985.git.mchehab+samsung@kernel.org>
         <87fu334p5v.fsf@purkki.adurom.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-05-07 at 15:37 +0300, Kalle Valo wrote:
> Mauro Carvalho Chehab <mchehab+samsung@kernel.org> writes:
> 
> > Sphinx produces a lot of errors like this:
> > 	./include/net/mac80211.h:2083: warning: bad line:  >
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> 
> Randy already submitted a similar patch:
> 
> https://patchwork.kernel.org/patch/10367275/
> 
> But it seems Johannes has not applied that yet.

Yeah, I've been super busy preparing for the plugfest.

I'll make a pass over all the patches as soon as I can, hopefully today
or tomorrow.

johannes
