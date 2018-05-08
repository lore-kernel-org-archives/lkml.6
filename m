Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754892AbeEHNNW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 09:13:22 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53228 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752191AbeEHNNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 09:13:21 -0400
Date: Tue, 8 May 2018 15:13:09 +0200
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Jane Wan <Jane.Wan@nokia.com>
Cc: Boris.Brezillon@bootlin.com, miquel.raynal@bootlin.com,
        dwmw2@infradead.org, computersforpeace@gmail.com, richard@nod.at,
        marek.vasut@gmail.com, yamada.masahiro@socionext.com,
        prabhakar.kushwaha@nxp.com, shawnguo@kernel.org,
        jagdish.gediya@nxp.com, shreeya.patel23498@gmail.com,
        ties.bos@nokia.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mtd: rawnand: fsl_ifc: use bit-wise majority to
 recover the contents of ONFI parameter
Message-ID: <20180508151309.40a78259@windsurf.home>
In-Reply-To: <1525710855-8159-1-git-send-email-Jane.Wan@nokia.com>
References: <1525710855-8159-1-git-send-email-Jane.Wan@nokia.com>
Organization: Bootlin (formerly Free Electrons)
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon,  7 May 2018 09:34:15 -0700, Jane Wan wrote:
> Per ONFI specification (Rev. 4.0), if all parameter pages have invalid
> CRC values, the bit-wise majority may be used to recover the contents of
> the parameter pages from the parameter page copies present.
> 
> Signed-off-by: Jane Wan <Jane.Wan@nokia.com>

Minor nit: the commit title contains "fsl_ifc", but this commit doesn't
change anything in the fsl_ifc driver, it fixes the NAND core.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
