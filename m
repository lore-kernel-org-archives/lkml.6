Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753130AbeDQMLE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 08:11:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:39689 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753111AbeDQMLC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 08:11:02 -0400
Date: Tue, 17 Apr 2018 14:11:00 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc: Peter Hutterer <peter.hutterer@who-t.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] HID: input: do not increment usages when a
 duplicate is found
In-Reply-To: <20180416235156.GE77055@dtor-ws>
Message-ID: <nycvar.YFH.7.76.1804171410360.28129@cbobk.fhfr.pm>
References: <20171208142818.15156-1-benjamin.tissoires@redhat.com> <20171208142818.15156-3-benjamin.tissoires@redhat.com> <20171210222926.GB11027@jelly> <20180416235156.GE77055@dtor-ws>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Apr 2018, Dmitry Torokhov wrote:

> So what is happening with this series? I think we should get it them
> in; there is really no reason for bumping ABS_MISC till it gets into
> ABS_MT_* range on some devices that are out there.
> 
> FWIW
> 
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Sorry, I somehow lost this one. Now queued for 4.18.

Thanks,

-- 
Jiri Kosina
SUSE Labs
