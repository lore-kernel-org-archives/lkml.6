Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933816AbeEIHoR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 03:44:17 -0400
Received: from s3.sipsolutions.net ([144.76.63.242]:39968 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933383AbeEIHoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 03:44:16 -0400
Message-ID: <1525851852.6910.1.camel@sipsolutions.net>
Subject: Re: linux-next: build warning after merge of the mac80211-next tree
From: Johannes Berg <johannes@sipsolutions.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>
Date: Wed, 09 May 2018 09:44:12 +0200
In-Reply-To: <20180509145624.643d2e56@canb.auug.org.au>
References: <20180509145624.643d2e56@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Stephen,

The 0-day bot also gave me this heads-up, there are a few more places
like it too. I'd asked Toke to fix the ones in the stack, but we both
missed the ones in the drivers. I'll get a fix in for that one way or
the other.

johannes
