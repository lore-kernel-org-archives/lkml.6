Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752564AbeEOJLM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 05:11:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:53316 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752240AbeEOJLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 05:11:10 -0400
Date: Tue, 15 May 2018 11:11:08 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        =?ISO-8859-15?Q?Cl=E9ment_VUCHENER?= <clement.vuchener@gmail.com>,
        Cameron Gutman <aicommander@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>
Subject: Re: [PATCH v9 0/2] hid-steam driver with user mode client dection
In-Reply-To: <20180504101631.GA7496@casa>
Message-ID: <nycvar.YFH.7.76.1805151110100.27054@cbobk.fhfr.pm>
References: <20180416122703.22306-1-rodrigorivascosta@gmail.com> <nycvar.YFH.7.76.1805041008100.27054@cbobk.fhfr.pm> <20180504101631.GA7496@casa>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 May 2018, Rodrigo Rivas Costa wrote:

> > If noone has any objections (last chance to raise them), I'll be 
> > queuing this for 4.18.
> 
> That would be great, thanks!
> 
> Now that my distro upgraded to 4.16, without the hid-quirks array, I've been
> testing it a bit more. 
> 
> It works great, but I've noticed that I've missed a couple of lines when
> creating the client hdev.  It doesn't seem to cause any harm, and anyway 'type'
> and 'country' are currently both 0 in my controller; only 'version' is visibly
> different but who uses that?
> 
> Anyway, this would be the change, I don't know if it is worth a whole reroll...

I've put this on top of your patches and queued in for-4.18/hid-steam. 
Thanks,

-- 
Jiri Kosina
SUSE Labs
