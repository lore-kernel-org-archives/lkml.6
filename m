Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752669AbeFAQnX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 12:43:23 -0400
Received: from smtprelay.synopsys.com ([198.182.37.59]:43058 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752429AbeFAQnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 12:43:19 -0400
From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
CC: Cupertino Miranda <Cupertino.Miranda@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Claudiu Zissulescu <Claudiu.Zissulescu@synopsys.com>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH] ARC: Explicitly specify OUTPUT_FORMAT in the linker
 script
Thread-Topic: [PATCH] ARC: Explicitly specify OUTPUT_FORMAT in the linker
 script
Thread-Index: AQHT+ZYsyZ39NSriOE6IpELFaDAo26RLcecAgAAIqIA=
Date: Fri, 1 Jun 2018 16:43:14 +0000
Message-ID: <fa3f7d80855306d96dcaea52f5dc2b783d5bceb1.camel@synopsys.com>
References: <20180601104904.48481-1-abrodkin@synopsys.com>
         <05b33c2b-6fb4-6a51-c52b-a0b1012a1000@synopsys.com>
In-Reply-To: <05b33c2b-6fb4-6a51-c52b-a0b1012a1000@synopsys.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.8.87]
Content-Type: text/plain; charset="utf-8"
Content-ID: <70DE2AD86C060F439A49A5D43C99CC62@internal.synopsys.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w51GioVp015927

Hi Vineet,

On Fri, 2018-06-01 at 09:12 -0700, Vineet Gupta wrote:
> On 06/01/2018 03:49 AM, Alexey Brodkin wrote:
> > It might be a good idea to explicitly specify BFD format
> > depending on -EB/-EL option passed to the linker and not rely on
> > default behavior as we have now.
> 
> What exactly is the problem we are trying to solve here ?
> Is this preventive or did you run into something - if latter can u explain it here
> please ?

Right, this is preventive patch.
As Claus mentioned that's good to have this explicit information for BFD but
otherwise there's no clear requirement or even recommendation on OUTPUT_FORMAT
usage so that might not be needed.

-Alexey
