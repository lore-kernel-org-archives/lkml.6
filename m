Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966216AbeBNACJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 19:02:09 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:49233 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966132AbeBNAB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 19:01:56 -0500
Subject: Re: plan9 semantics on Linux - mount namespaces
To: Aleksa Sarai <asarai@suse.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>
References: <0f058286-a432-379b-f559-f2fe713807ab@metux.net>
 <5633d335-3926-d98f-d6d7-948b1e2a0b2c@metux.net>
 <20180213222751.p3fyg7whg6jqlzz5@gordon>
From: Enrico Weigelt <lkml@metux.net>
Organization: metux IT consult
Message-ID: <39b08c53-3449-3164-c1b1-44ac587dd4ea@metux.net>
Date: Wed, 14 Feb 2018 00:01:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180213222751.p3fyg7whg6jqlzz5@gordon>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:ejRdENjoNjV5Bi+ASOpGNs+AM3RTD/MJnVzN4Ej/4c+FP/RvwDP
 xWUeaylGOFEQScLwOeL2rwfm7SK79TOZDGcxnp5qt7jLz3ltMzE+dpD8BH9OitdOlM14gos
 0708rc0dGkyM6o13+Wja5J3zgiDWgDui5oLd6UMRw0HtQzMIsuqGvDk1AH0hrEYu5owIJ2J
 MdYNyZ8vHKYE+Csy/cvBQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YcZIdXVRwWM=:fLC28Eh0gX7HbStlghAvP9
 xmjnRssFCjHRallj2XidddxR7kH7zlEy181F0JsnFe7Do0YuD3rMW4ip2aRqWFbsHLSLubeOE
 o9pBkqWK0JJm16PPyY8cDdVdvsMfXocSHzqC7vhrDLZRjQRFCzW/FKY4u6JaiFpHNI96POjIK
 PC3Pcu1muvUKeE6R/bdTmIyLTDHkBP7q7e+/RktvndlEFjAXgi8QAFiXmTUevOTwFJm7yOmJZ
 MygajSdiaQlH6mH+DEFLFlhVuN6QCTEvFwswu8Oc+Xe7cn3ynINUKLZ9pb3slhDSRfHI0WtjF
 3B/Prwph4UF9yzcY9Rl0rymdkJ6Vio0vLDarQd196WwAygaIXJCZU1lOR6Nir0VTAsOTo+YKx
 XzaLeu1MXCnBQAOWDNwMhO3P83PKpxi/sWgwL3cYlC93i+yF99H+yaTUUMCrCyp3ED4HuPN5J
 yDBewix52URHmiIMx2TsELKD+cEA1+9D1w1m2gK2o0KrneEdgTkQACiCSRxtXAuvdPpmlgyEV
 ksO0RA5XPiCEq0EboZ2w4q4Tm6k6vALGTMVwRo18dr0R/Tbr9dalfs0ftGiXaoFHghyQuDftL
 ds4+2YVrxz1KRUmlsBJO1vnf7LSBIjlxRMXkcKtiqmpn/KeqJgu+8tocIV1XxFMUZVQxLpDvw
 2v/O2ck5WcciLPWzAYzJ/6biQADSuAOFBIjfcnQLr2p2MMeRyO8giwGNb/BjtbNwFGflb1dej
 US7KjfynfCmnf25KwVp8uW86n5fZ19sVsDA7NUdMgmqMh2v6slFaFcsAU3g=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.02.2018 22:27, Aleksa Sarai wrote:

> You can do this by creating a new user namespace (CLONE_NEWUSER), which
> then gives you the required permissions to create other namespaces
> (CLONE_NEWNS). This is how "rootless containers" or unprivileged
> containers operate.

hmm, unshare -U doesn't work for me (even as root). But docker works,
so user namespaces should be working. Any idea what could be wrong ?


--mtx


-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
