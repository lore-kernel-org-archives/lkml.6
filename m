Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752285AbeDZFvJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 01:51:09 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54703 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750924AbeDZFvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 01:51:08 -0400
Date: Thu, 26 Apr 2018 07:51:06 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Paul Menzel <pmenzel+linux-random-number@molgen.mpg.de>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: Linux messages full of `random: get_random_u32 called from`
Message-ID: <20180426055106.GA4977@amd>
References: <42c1b84b-ab1f-5577-6304-e0985a637cf9@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42c1b84b-ab1f-5577-6304-e0985a637cf9@molgen.mpg.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Since Linux 4.17-rcX, Linux spams a lot of `random: get_random_u32 called
> from` messages. I believe, this setting should be reverted by default as
> otherwise a lot of other messages are not seen.
> 
> Please find my configuration attached.

Same here, thinkpad X60:

[    3.163839] systemd[1]: Failed to insert module 'ipv6'
[    3.181266] systemd[1]: Set hostname to <amd>.
[    3.267243] random: systemd-sysv-ge: uninitialized urandom read (16
bytes read)
[    3.669590] random: systemd-sysv-ge: uninitialized urandom read (16
bytes read)
[    3.696242] random: systemd: uninitialized urandom read (16 bytes
read)
[    3.700066] random: systemd: uninitialized urandom read (16 bytes
read)
[    3.703716] random: systemd: uninitialized urandom read (16 bytes
read)
[    3.756137] random: systemd: uninitialized urandom read (16 bytes
read)
[    3.760460] random: systemd: uninitialized urandom read (16 bytes
read)
[    3.764515] random: systemd: uninitialized urandom read (16 bytes
read)
[    3.835312] random: systemd: uninitialized urandom read (16 bytes
read)
[    4.173204] systemd[1]: Binding to IPv6 address not available since
kernel does not support IPv6.
[    4.176977] systemd[1]: [/lib/systemd/system/gpsd.socket:6] Failed
to parse address value, ignoring: [::1]:2947
[    4.186472] systemd[1]: Starting Forward Password Requests to Wall
Directory Watch.
[    4.188845] systemd[1]: Started Forward Password Requests to Wall
Directory Watch.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
