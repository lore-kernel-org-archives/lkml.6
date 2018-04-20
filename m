Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754775AbeDTMh3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 08:37:29 -0400
Received: from mout.gmx.net ([212.227.17.20]:55225 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754591AbeDTMh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 08:37:28 -0400
Message-ID: <1524227844.6103.1.camel@gmx.de>
Subject: Re: DOS by unprivileged user
From: Mike Galbraith <efault@gmx.de>
To: Ferry Toth <ftoth@telfort.nl>
Cc: lkml <linux-kernel@vger.kernel.org>
Date: Fri, 20 Apr 2018 14:37:24 +0200
In-Reply-To: <1911073.n8LaRrY1S6@ferry-quad>
References: <9023506.UBh6vynRGa@delfion> <1524199618.5757.3.camel@gmx.de>
         <1911073.n8LaRrY1S6@ferry-quad>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:NSyCyRQYdKXVfWYiX8LtuGCnvFd73yTKgRYgm2xqqA8iZ7g13lm
 Y3eQuC+MPlUOnvg18W98jjz8b4yFtUX/OlluboLpc46ynKkVZD0cgEV/QFu3C0j5gUwrha/
 MZbMHojWMb7E4YgB2QwVMzidBpNH9Bx7aM7R8ZkWvmC9BFqF7SM0GrTlTYkgkC+Sp8EbuIn
 2GoyBr97IN7tJrJ69ITvQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kdb/fhsY1nI=:NaO0ILz9VnKsotMoI5bGhM
 S/yviYpZlJ5zgfs/eIIchBtvlnyHJpFetr0ooKSY4YcclEGJMZwdGbWtcxx+brTvyWO8gMnV5
 x6SXMIKavEhd2d5NEM3I3QuLcJNMfS9fRrxQ7zY8HUQg0U4J9624nw+7Ju9bT+aUfYuDkLlZq
 iPHQFf/mxqqqtxrG+/Os9WbQM5FntSYDvD+68/22qTiHwzvPnX2NitmkW2SV2ZQLgu/eelWdY
 pFkYx06iSeAnp4o6Ug6mK82jbk7AiL9VCBE4bLO6sIyKfZa7hmsHOFSXo5kwB87fI+cqp9Yzd
 RNqHt5lKJ4RX6x7t9eL06BTckJNZSUAHv/t8QtOPVGc/oB2PBoENe3DVOFa5iCYRx6oK/1AQo
 UFyvx1O4zgbmmZz6P7qJm3V5W09J4cZUJAKUpEJxHuS1naAQ5V5BMfOxveJirVI2ehPzTp87s
 SRgdXMmFxOLS50qTbnnOOmp67CAsqxw2n+yI/Lp/eP33IKsvBI8OikPe/j5iESaDr5ckxxJQi
 O2LGU7e99ZlAu6H76v5k2twRa8pRud4/nw9psU8WD3LTtu3ZQxhQnKg1WOvB6JMRilEF2UiEU
 W/nt247TLn2AejT65ieO1SmqDLASqGZrsAPusIs3KJJxWxUjD6VecVQB6+2xGzU+luP1EqaEp
 nUkLTEqfCO+BIHEU1LA+YqcKeugiB2p0JXevqAVigSf/N2FmT/zc52e+fjzteK8KmZR46nBSj
 mnvlHEkzwEUitm6o78Bc/1rrjfYhVVzWYOqV08rlQoLCiYXxFnwfZHbbeBptqgEKDy9J6rqif
 9gw7zNA0tMH7J2fR96XPxRBYQ0fJUezqaTHEruHelEy4hAIUOc=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-04-20 at 10:39 +0200, Ferry Toth wrote:
> 
> Nevertheless I feel one process should not be allowed to harm other
> processes by denying them resources. Even if when btrfs makes it easy
> abuse I think the scheduler should have throttled gitk.

Memory management is not in it's job description.

	-Mike
