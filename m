Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933687AbeEWPli (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 11:41:38 -0400
Received: from foss.arm.com ([217.140.101.70]:57400 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933548AbeEWPld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 11:41:33 -0400
Date: Wed, 23 May 2018 16:41:25 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Ilia Lin <ilialin@codeaurora.org>
Cc: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, robh@kernel.org,
        mark.rutland@arm.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v11 0/2] Kryo CPU scaling driver
Message-ID: <20180523154125.GA30427@e107155-lin>
References: <b4c28b51-ecd5-649b-e8fa-e5ce1bbb3139@arm.com>
 <f53d6035-d409-4535-9dd0-03baedc9b4a8@email.android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f53d6035-d409-4535-9dd0-03baedc9b4a8@email.android.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 06:34:06PM +0300, Ilia Lin wrote:
> It may be merged alone safely. However to actually work, it needs a clock
> driver as well, and the OPP tables in tue device tree. Those are submitted now
> 8n 2 separate series. This is in order to provide each maintainer with domain
> specific series, as per Viresh's suggestion.

I understand that. I was trying to get overall structure to better understand
how it all glue together in the system(just for self education).

--
Regards,
Sudeep
