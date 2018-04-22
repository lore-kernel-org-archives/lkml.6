Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751559AbeDVKUf (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 06:20:35 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58959 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750916AbeDVKUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 06:20:35 -0400
Date: Sun, 22 Apr 2018 12:20:33 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Paul Menzel <pmenzel+linux-kernel@molgen.mpg.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: How to disable Linux =?utf-8?Q?kernel_?=
 =?utf-8?Q?self-extraction_=28KERNEL=5FGZIP=2C_KERNEL=5FBZIP2=2C_=E2=80=A6?=
 =?utf-8?B?KT8=?=
Message-ID: <20180422102033.GB26243@amd>
References: <9468be0e-5eb9-246c-e60e-3d8019a42fd1@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9468be0e-5eb9-246c-e60e-3d8019a42fd1@molgen.mpg.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-04-20 16:36:00, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> I try to decrease boot time, and my system has an SSD and enough space, so
> loading 18 instead of 12 MB doesn’t make a difference, but the
> self-extraction is noticeable. So, I like to disable it.

How long does GZIP extraction take on your hardware?


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
