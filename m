Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753001AbeDLNLG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 09:11:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:59510 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752437AbeDLNLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 09:11:04 -0400
Date: Thu, 12 Apr 2018 15:11:02 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
cc: masaki.ota@jp.alps.com, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 0/4] HID: alps: Fix some bugs and improve code around
 't4_read_write_register()'
In-Reply-To: <nycvar.YFH.7.76.1803271405420.15778@cbobk.fhfr.pm>
Message-ID: <nycvar.YFH.7.76.1804121510340.28129@cbobk.fhfr.pm>
References: <cover.1521492069.git.christophe.jaillet@wanadoo.fr> <nycvar.YFH.7.76.1803271405420.15778@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Mar 2018, Jiri Kosina wrote:

> > These patches are untested. Especially, patch 1 slightly changes the behavior
> > of 't4_read_write_register()'.
> > This looks logical to me, but please, review it carefully.
> > 
> > Christophe JAILLET (4):
> >   HID: alps: Report an error if we receive invalid data in
> >     't4_read_write_register()'
> >   HID: alps: Save a memory allocation in 't4_read_write_register()' when
> >     writing data
> >   HID: alps: Check errors returned by 't4_read_write_register()'
> >   HID: alps: Fix some style in 't4_read_write_register()'
> > 
> >  drivers/hid/hid-alps.c | 27 ++++++++++++++++++++++-----
> >  1 file changed, 22 insertions(+), 5 deletions(-)
> 
> Masaki-san,
> 
> do you have any comments to Christophe's patchset please?

If there is no feedback, I'll queue the set for 4.18.

Thanks,

-- 
Jiri Kosina
SUSE Labs
