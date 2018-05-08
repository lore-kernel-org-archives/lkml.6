Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755388AbeEHPoX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 11:44:23 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:38106 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755059AbeEHPoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 11:44:20 -0400
X-Google-Smtp-Source: AB8JxZpFle2BERyzUUPKBSpGwPsnW9Hllh5NsTve9AVTkdakeznNMNqnRgX09dM5Audttcdu0GB6Cw==
Date: Tue, 8 May 2018 17:44:16 +0200
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-kernel@vger.kernel.org,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] mptlan: fix mpt_lan_sdu_send()'s return type
Message-ID: <20180508154415.neutsgpi2nwffwec@ltop.local>
References: <20180424131558.3010-1-luc.vanoostenryck@gmail.com>
 <yq1h8niyb63.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1h8niyb63.fsf@oracle.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 08, 2018 at 01:21:56AM -0400, Martin K. Petersen wrote:
> 
> Luc,
> 
> > The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
> > which is a typedef for an enum type, but the implementation in this
> > driver returns an 'int'.
> 
> You forgot to update the function prototype accordingly.

Hmmm, the function mpt_lan_sdu_send() has no other declaration
than the one I modified the return type in this patch.

Must be a misunderstanding somewhere.

-- Luc
