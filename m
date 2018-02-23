Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751651AbeBWMlO convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 07:41:14 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:44711 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751408AbeBWMlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 07:41:13 -0500
Date: Fri, 23 Feb 2018 12:41:05 +0000
User-Agent: K-9 Mail for Android
In-Reply-To: <20180223010545.GC15876@fieldses.org>
References: <20180222151723.7d381e77@canb.auug.org.au> <12138EE4-77CA-480F-B2F9-B4C7E4E20891@ettle.org.uk> <20180223010545.GC15876@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: linux-next: Signed-off-by missing for commit in the nfsd tree
To: "J. Bruce Fields" <bfields@fieldses.org>
CC: Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: James Ettle <james@ettle.org.uk>
Message-ID: <440587E4-661C-4E73-A954-8329593DAE4F@ettle.org.uk>
X-Provags-ID: V03:K0:Q2bsyhzLuTFYEQbs6CgI9EpcRRtFlHc1Z139+tt8/kM/u37SlwH
 ieCCLnof3o+FpeENpb3t/e/EbAaCip0rTGzhfhZ2jyNe6GLVj03rhq6DPyyMgLX/uzIzvUN
 KvMQcSDEA2JbSqkLNbTK8kxY0nh6m0G0GfTTz2Vi9pC/ViRosYyPeebrHCkrb5oRsnpwl6W
 /cTPI5DgzDYM7LN9VHrcQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/UWYtcpCpf8=:/Jy5ZUgL9DF2+jzGjiZ7Tq
 uh1PJnsfWASPZuynfjyp42fMsY+oQUwnXIBa74jbTs5GIcxF4ZpfdQtr8j4ta/bJUAqXGccMh
 lvKVUfTe4hy/gPDg1XLXBbIyiGGnZ0DnPBdlxbXGKYtgzZuwWOEbkEqOpBDaC2bgOfL6sHXRL
 Tj+82bHBCEdINBr8ivCAilep3Oj+cnp1d5m+ytc3/OXf1TibA6i/RbJgv26S7ujKzbGpF4qor
 kmkO7uLXTB5oVoBCdnAmq1tTiB196ApgVpop2Xh1pnhjxa5aMQ12EyyTFYZxp50rGj1pHz2A0
 K6zD4s6WCvFxCGPynY92nyK4w9LrgGHYGNlS3dNhvHfcJc25as1U/gpAseHqQ0dCBcPtHRhaW
 M96CbjyrAGJDnoiSPfFkpxCiCl1Ue3EaDVQ76U86fji8PNTc7sjxWVCMNNcVPo7egtHsRX4Rt
 JmDFf9No2tVmetCSYQPPaPQGDcXHkExwq/UHf0FoqO7w+gVXNZdp79GfTSZkv5Y+1yValmz2d
 sFDLWmEctWhfJfm3B9hL3c7k+dhPOAGxwXC3Oneq1/39PY6W8//EeX9PX6ZTf4nCvWaGZqDjb
 YeBpfzyaNB6qhb86eQEdbGOqi8T99Y9SjtYLhPq8i03D138BGysSrEGnmbWP30FFTAXZfOG2C
 2cvXi6CUwQnq2LqXoLjbThOuQ4zEiqIC142qWg55/yk3P/nx5BKhaNhDgAJ3cSFc6Pn8kuf00
 +OfCdEvig78i/78fYjcV33DszS7+Di5nTxVx3AcVWXLCihOYpg6yL04HlUA=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm OK with that. (This is the first time I've ventured into kernel space so I thought it better to at least sketch a solution and let the experts do it correctly ;) Glad it's passed the review!)

Thanks,
James.

On 23 February 2018 01:05:45 GMT+00:00, "J. Bruce Fields" <bfields@fieldses.org> wrote:
>On Thu, Feb 22, 2018 at 06:39:43AM +0000, James Ettle wrote:
>> I only really posted this as a demo of a fix. I was hoping someone
>who actually knows what they're doing in the kernel would pick it up
>and make it proper.
>
>Whoops, sorry, I didn't realize that.
>
>But I don't see a problem with the patch as it is.  Are you OK with me
>adding your signed-off-by?
>
>--b.
>
>> 
>> Thanks,
>> James.
>> 
>> 
>> On 22 February 2018 04:17:23 GMT+00:00, Stephen Rothwell
><sfr@canb.auug.org.au> wrote:
>> >Hi,
>> >
>> >Commit
>> >
>> >  35da1ba8af70 ("sunrpc: Fix unaligned access on sparc64")
>> >
>> >is missing a Signed-off-by from its author.
>> >
>> >-- 
>> >Cheers,
>> >Stephen Rothwell
