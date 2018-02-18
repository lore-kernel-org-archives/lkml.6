Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751451AbeBRNRO (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 08:17:14 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:42845 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751315AbeBRNRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 08:17:12 -0500
X-Google-Smtp-Source: AH8x225CFhzfpqzdo0E54YfoRypOIfTWfcqK+2FnOdPZr1DNsXyeGpZVjT1m03A5FqsUh3OnmbxtnA==
Date: Sun, 18 Feb 2018 05:17:08 -0800
From: Tejun Heo <tj@kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-ide@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/3] pata_arasan_cf: Delete an unnecessary variable
 initialisation in arasan_cf_probe()
Message-ID: <20180218131708.GZ695913@devbig577.frc2.facebook.com>
References: <d492f9d2-ed64-e858-441a-fa554369032c@users.sourceforge.net>
 <3b6bfa0f-3356-2fb9-07ae-bf52c1ccc47e@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b6bfa0f-3356-2fb9-07ae-bf52c1ccc47e@users.sourceforge.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 04:59:01PM +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 16 Feb 2018 16:28:23 +0100
> 
> The local variable "ret" will eventually be set to an appropriate value
> a bit later. Thus omit the explicit initialisation at the beginning.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Applied 1-2 to libata/for-4.17.

Thanks.

-- 
tejun
