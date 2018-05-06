Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751899AbeEFW3W (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 18:29:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42486 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751854AbeEFW3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 18:29:21 -0400
Date: Sun, 6 May 2018 15:29:15 -0700
From: Darren Hart <dvhart@infradead.org>
To: Mario.Limonciello@dell.com
Cc: lkp@intel.com, kbuild-all@01.org, linux-kernel@vger.kernel.org
Subject: Re: drivers/platform/x86/dell-smbios-smm.c:99: undefined reference
 to `dcdbas_smi_request'
Message-ID: <20180506222826.GA18546@fury>
References: <201805050216.HVwTWQoD%fengguang.wu@intel.com>
 <66cb778b7f9844eda89d2eec11158acc@ausx13mpc120.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66cb778b7f9844eda89d2eec11158acc@ausx13mpc120.AMER.DELL.COM>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 06:27:00PM +0000, Mario.Limonciello@dell.com wrote:
> Darren,
> 
> Is this with that fix of mine merged?  

FYI: This fix has now been merged to linus/master.

-- 
Darren Hart
VMware Open Source Technology Center
