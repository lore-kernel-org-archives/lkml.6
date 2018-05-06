Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751563AbeEFKKo (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 06:10:44 -0400
Received: from mondschein.lichtvoll.de ([194.150.191.11]:45643 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751200AbeEFKKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 06:10:43 -0400
Authentication-Results: auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
From: Martin Steigerwald <martin@lichtvoll.de>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: jdow <jdow@earthlink.net>, Geert Uytterhoeven <geert@linux-m68k.org>,
        Matthew Wilcox <willy@infradead.org>, David Sterba <dsterba@suse.cz>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-m68k <linux-m68k@vger.kernel.org>
Subject: Re: moving affs + RDB partition support to staging?
Date: Sun, 06 May 2018 12:10:40 +0200
Message-ID: <1580998.mIZvI3OA13@merkaba>
In-Reply-To: <f8a044e8-01b0-7008-49ac-7e9c5ce7defd@physik.fu-berlin.de>
References: <20180425154602.GA8546@bombadil.infradead.org> <7a997bb7-7f1c-e8b4-667c-3993f1d82e7c@earthlink.net> <f8a044e8-01b0-7008-49ac-7e9c5ce7defd@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

John Paul Adrian Glaubitz - 06.05.18, 10:52:
> On 04/27/2018 03:26 AM, jdow wrote:
> > And before I forget there are two features of the RDBs that I
> > heartily recommend never implementing on Linux. They were good
> > ideas at the time; but, times changed. The RDBs are capable of
> > storing a filesystem driver and some drive init code for the plugin
> > disk driver card. That is giving malware authors entirely goo easy
> > a shot at owning a machine. Martin S., I would strongly suggest
> > that going forward those two capabilities be removed from the RDB
> > readers in AmigaOS as well as Linux OS.
> 
> I assume removing the feature for AmigaOS isn't really possible since
> we don't have the source code for that, do we?

AmigaOS 4.x does not support loading filesystems from RDB anymore as far 
as I know. Meanwhile I am not involved with the AmigaOS development 
anymore, but that is the last state I know. Similarily to Linux 
filesystems drivers are loaded as "modules" into the kernel. Its also 
still possible to load a filesystem as a file from disk, but that does 
not work for the filesystem the kernel boots from. The AmigaOS kernel 
still decides which of the kernel filesystem to use according to the 
DOSType of the partition.

Thanks,
-- 
Martin
