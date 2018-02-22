Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932814AbeBVOkz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 09:40:55 -0500
Received: from mail01.prevas.se ([62.95.78.3]:30587 "EHLO mail01.prevas.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932623AbeBVOky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 09:40:54 -0500
X-IronPort-AV: E=Sophos;i="5.47,377,1515452400";
   d="scan'208";a="3291205"
Subject: Re: [PATCH] EDAC, layerscape: allow building for LS1021A
To: York Sun <york.sun@nxp.com>
CC: Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alexander Stein <alexander.stein@systec-electronic.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180220150912.2954-1-rasmus.villemoes@prevas.dk>
 <BCC182D6-3CC0-40F1-B17A-0E410A20ACC4@nxp.com>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <2d3abe84-e305-1823-5cdf-b6210342224b@prevas.dk>
Date: Thu, 22 Feb 2018 15:40:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <BCC182D6-3CC0-40F1-B17A-0E410A20ACC4@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.8.31]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-20 22:01, York Sun wrote:
> Sorry for top posting. I am on vacation and replying from my phone.
> 
> The controller is compatible and the driver should work. Please double check to make sure you can inject errors and receive interrupt. After that you are good to go.

I can indeed inject errors and get the interrupt.

Thanks,
Rasmus
