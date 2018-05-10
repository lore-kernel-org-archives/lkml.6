Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757403AbeEJN1X (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 09:27:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:44892 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756998AbeEJN1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 09:27:22 -0400
Date: Thu, 10 May 2018 15:27:19 +0200
From: Jean Delvare <jdelvare@suse.de>
To: Anders Roxell <anders.roxell@linaro.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: i801: mark PM functions as __maybe_unused
Message-ID: <20180510152719.6e37b10e@endymion>
In-Reply-To: <20180509190055.61ad929b@endymion>
References: <20180508073852.16840-1-anders.roxell@linaro.org>
        <20180509190055.61ad929b@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 May 2018 19:00:55 +0200, Jean Delvare wrote:
> If SIMPLE_DEV_PM_OPS causes it but UNIVERSAL_DEV_PM_OPS did not, I
> suppose that what matters is CONFIG_PM_SLEEP.
> 
> So maybe we can just replace "#ifdef CONFIG_PM" with "ifdef
> CONFIG_PM_SLEEP" in the code below?

It seems that drivers i2c-brcmstb, i2c-mpc, i2c-ocores, i2c-pnx,
i2c-puv3, i2c-st, i2c-stu300 and i2c-mux-pca954x are doing exactly that
already, so that must be a valid way to solve the problem.

Will you send a new patch?

Thanks,
-- 
Jean Delvare
SUSE L3 Support
