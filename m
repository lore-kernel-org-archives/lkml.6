Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751699AbeFEFze (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 01:55:34 -0400
Received: from mout3.freenet.de ([195.4.92.93]:38964 "EHLO mout3.freenet.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751578AbeFEFzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 01:55:32 -0400
Subject: Re: Spectre mitigation doesn't seem to work at all?!
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <141672d1-8dcb-9a84-7f8f-60c7a2c58b07@01019freenet.de>
 <20180604081502.GE12258@hirez.programming.kicks-ass.net>
 <d8fbee2d-305a-9fc0-356e-b8d4cbd59dbd@maya.org>
 <20180604151251.1fb34793@alans-desktop>
From: Andreas Hartmann <andihartmann@01019freenet.de>
Openpgp: preference=signencrypt
Autocrypt: addr=andihartmann@01019freenet.de; keydata=
 xsDiBDz/vtQRBAC+OSpes1p57fA8ENLYy3Nl/CpEvtRoDdhy7DPyc1+adE57vpK52naRfaZB
 f0RSMvIZwJYggMio+emiN5Du7kL9y2IEjmHBvp/1x68dEwswHP9X4hJmHmyOJL3IB2WsvEdh
 QF97913bWX34MYCeuOoSJ1OWvBLGfNs0zv70HOTfJwCgricyy8N1itEryLwoeu5HWz0SmDED
 /2IiuDhPZ332i0Ylp40RQb2Wb0xBvpscVeRZDItsYYbJ/Sgmso1sn93sFFWmmrvGUyg3MNCt
 +u+7P8Wg3VXte8cHbNwdzNtXHTfYyTcgZXC4xJN2akZt4pdR531mXyP2kFxmKtAEmW6bNpvV
 oNnkgZVWvoT4BHLloLzA62JUEgFJA/9dHilAVS3Ezv5ECB02Lt2vNNzMvPlyNbxBhWnrb6VC
 mFMCRg9bOK2io1zYb8C4gEpJ33wl8hEBxOWfCOEEKesAUCjViosNvxqGNtGWjk5p1O2QBWE2
 D6u5+itACQRqhmmgNl+dK6Of2yGG9GxOYWozIELEfL9ZB4xQ7A2tDFR0Zs1HQW5kcmVhcyBI
 YXJ0bWFubiAod2VpbCBkZXIgUmVjaG5lciBuZXUgaGVpc3N0KSA8YW5kcmVhc0BkdWFsYy5t
 YXlhLm9yZz7CYAQTEQIAIAUCTMsY3gIbAwYLCQgHAwIEFQIIAwQWAgMBAh4BAheAAAoJEBhU
 mcTgYeNVT1QAoJ4cJ2jl6Jgmi+PmWCXPk4m8lgAGAKCjkxgK/PjE3+cNsLa/xEpReqYwRs7A
 TQQ8/77WEAQAqBBex8oxPC1srpaSFbq8NCM/Gy7SKucKsQPqG/De46WQESbmnMElVft2xCBC
 rOJ7E02k10h/twe0yQnNdXMJDMDM0w0EEyX9ljekIr3SFbXpU2S4wUl3C6CW2hizUgOyLsg0
 chpfGMB9+wiVycyjZahafoc14wuuDj5BqWEOCccAAwcD/14lh1PTPKx4hs7ITtFZh5TI6+5f
 xAWIBBUeQL+GEt+CKwyNc/hWp8YTPJ3SAedmDrEMX+2yPO95KeIfg6bnnIVvI/aTR/vJFsWK
 GKMx+KaKx+IEwuhCpNIMUASpJWRvVlo3lMIvqAMJIBj79uKq/X9fppblcJst29QVO6aWf3Gh
 wkYEGBECAAYFAjz/vtYACgkQGFSZxOBh41VBAgCfZRiPCQ+jNvdT5iR2fEblqTtBrF0An0nb
 M8B1Lpkm44214BbtIQKneVrY
Message-ID: <55e879f4-57c1-dc55-74ba-b1845cd5ded5@01019freenet.de>
Date: Tue, 5 Jun 2018 07:53:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180604151251.1fb34793@alans-desktop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-score: -3.8
X-Spamreport: Action: no action
 Symbol: ASN(0.00)
 Symbol: SUBJECT_ENDS_EXCLAIM(0.00)
 Symbol: RCPT_COUNT_THREE(0.00)
 Symbol: MIME_GOOD(-0.10)
 Symbol: RCVD_TLS_ALL(0.00)
 Symbol: MID_RHS_MATCH_FROM(0.00)
 Symbol: RCVD_COUNT_TWO(0.00)
 Symbol: TO_MATCH_ENVRCPT_ALL(0.00)
 Symbol: FROM_HAS_DN(0.00)
 Symbol: FROM_EQ_ENVFROM(0.00)
 Symbol: BAYES_HAM(-0.68)
 Symbol: SUBJECT_HAS_QUESTION(0.00)
 Symbol: TO_DN_ALL(0.00)
 Symbol: NEURAL_HAM(-2.97)
 Symbol: RCVD_VIA_SMTP_AUTH(0.00)
 Message-ID: 55e879f4-57c1-dc55-74ba-b1845cd5ded5@01019freenet.de
X-FN-Spambar: 
X-Originated-At: 2003:de:53d7:1800:5054:ff:fe15:ac42!45556
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2018 at 04:12 PM Alan Cox wrote:
>> A malicious program most probably won't care about that. Therefore, my
>> next question is: which memory regions can be exploited by a malicious
>> program? The complete physical memory or only the memory provided to the
>> malicious program? Should be the latter if this approach should have any
>> impact.
> 
> Spectre is not about memory regions. It's about speculative execution
> leaving measurable footprints. What footprints you leave depend upon what
> code you are executing. Thus the question becomes 'what can the target
> access'.
> 
> In order to attack something you need both a way to influence the code
> concerned and a way to measure it. In addition it needs to have some
> secret you want.
> 
> In practice that usually means something on the same system with its own
> memory space/privilege level. The usual cases then are user<->kernel and
> managed application<->runtime.

Would this be a practical test case: Gather keys and passwords used by a
ssh login by running a malicious program in parallel to sshd as another
ordinary user w/o root access.


Thanks,
Andreas
