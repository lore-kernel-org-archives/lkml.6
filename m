Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752487AbeENIMT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 04:12:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:52729 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752207AbeENIMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 04:12:14 -0400
Date: Mon, 14 May 2018 10:12:00 +0200
From: Borislav Petkov <bp@suse.de>
To: Jean Delvare <jdelvare@suse.de>
Cc: kbuild test robot <lkp@intel.com>, Tony Luck <tony.luck@intel.com>,
        kbuild-all@01.org, linux-kernel@vger.kernel.org
Subject: Re: drivers/edac/skx_edac.c:399: undefined reference to
 `nfit_get_smbios_id'
Message-ID: <20180514081200.GA18407@pd.tnic>
References: <201805130419.XbKBtNfM%fengguang.wu@intel.com>
 <20180514100530.3f2d0667@endymion>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180514100530.3f2d0667@endymion>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 10:05:30AM +0200, Jean Delvare wrote:
> I'll send a candidate fix shortly.

https://lkml.kernel.org/r/3af91354-8e19-d2af-1bba-ced8dce053f1@infradead.org

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
