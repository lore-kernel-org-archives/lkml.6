Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755944AbeDZMfD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 08:35:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:33488 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754847AbeDZMfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 08:35:02 -0400
Date: Thu, 26 Apr 2018 14:34:59 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
cc: masaki.ota@jp.alps.com, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 0/4] HID: alps: Fix some bugs and improve code around
 't4_read_write_register()'
In-Reply-To: <cover.1521492069.git.christophe.jaillet@wanadoo.fr>
Message-ID: <nycvar.YFH.7.76.1804261434520.28147@cbobk.fhfr.pm>
References: <cover.1521492069.git.christophe.jaillet@wanadoo.fr>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Mar 2018, Christophe JAILLET wrote:

> All is said in the subject and below.
> 
> These patches are untested. Especially, patch 1 slightly changes the behavior
> of 't4_read_write_register()'.
> This looks logical to me, but please, review it carefully.
> 
> Christophe JAILLET (4):
>   HID: alps: Report an error if we receive invalid data in
>     't4_read_write_register()'
>   HID: alps: Save a memory allocation in 't4_read_write_register()' when
>     writing data
>   HID: alps: Check errors returned by 't4_read_write_register()'
>   HID: alps: Fix some style in 't4_read_write_register()'
> 
>  drivers/hid/hid-alps.c | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)

Queued for 4.18, thanks.

-- 
Jiri Kosina
SUSE Labs
