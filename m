Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162409AbeCAV6q (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 16:58:46 -0500
Received: from mail-qk0-f171.google.com ([209.85.220.171]:38624 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162159AbeCAV6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 16:58:43 -0500
X-Google-Smtp-Source: AG47ELt95wfjLf4spLZ0jGfMuMseQp/bnE54woJFBr5sHkNb103ggu6UqU92ywDAchaBCM7SbGZh5Q==
Date: Thu, 1 Mar 2018 13:58:39 -0800
From: Tejun Heo <tj@kernel.org>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pata_falcon: clarify license version and use SPDX header
Message-ID: <20180301215839.GC2421174@devbig577.frc2.facebook.com>
References: <CGME20180301111338epcas1p3986304526e78000c4f7b00f7154fc92a@epcas1p3.samsung.com>
 <2054548.du6VOAbhqL@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2054548.du6VOAbhqL@amdc3058>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2018 at 12:13:35PM +0100, Bartlomiej Zolnierkiewicz wrote:
> - clarify license version (it should be GPL 2.0)
> - use SPDX header
> 
> Cc: Michael Schmitz <schmitzmic@gmail.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Applied to libata/for-4.17.

Thanks.

-- 
tejun
