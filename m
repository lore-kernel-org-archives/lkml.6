Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751922AbeCaVAB (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 17:00:01 -0400
Received: from tn-76-7-162-187.sta.embarqhsd.net ([76.7.162.187]:54245 "EHLO
        animx.eu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751180AbeCaVAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 17:00:00 -0400
Date: Sat, 31 Mar 2018 16:59:59 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 4.15.14 crash with iscsi target and dvd
Message-ID: <20180331205959.GA21087@animx.eu.org>
References: <20180331015903.GA29398@animx.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180331015903.GA29398@animx.eu.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wakko Warner wrote:
> I reported this before but noone responded.
> 
> I have an iscsi target setup with /dev/sr[012] using pscsi.  On the
> initiator, I mount only 1 disc.  Then I issue find -type f | xargs cat >
> /dev/null  Then after a few seconds, I get 2 oops and the system has to be
> hard reset.
> 
> I noticed if I cat /dev/sr1 from the initiator, it doesn't crash.  I was
> also able to burn without crashing.

I'd like to add that 4.9.91 does not crash.  I haven't tested newer kernels
yet.
