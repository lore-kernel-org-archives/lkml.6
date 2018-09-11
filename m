Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A942DC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5649D2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:11:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5649D2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbeIKTKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 15:10:47 -0400
Received: from mout.gmx.net ([212.227.17.20]:41299 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbeIKTKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 15:10:47 -0400
Received: from [10.54.0.101] ([146.52.22.28]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LnCkb-1fMpCg4AAf-00hNg3; Tue, 11
 Sep 2018 16:11:16 +0200
Cc:     stable@vger.kernel.org
To:     linux-kernel@vger.kernel.org
From:   =?UTF-8?Q?Georg_M=c3=bcller?= <georgmueller@gmx.net>
Subject: Missing mei patches
Openpgp: preference=signencrypt
Autocrypt: addr=georgmueller@gmx.net; prefer-encrypt=mutual; keydata=
 xsDiBD1O6uYRBADzyVXlOCHhmtVG0ttc5ryyNkmTL1xkhuFxygpnAnGA3T1Me0xZ1792b5/l
 1SkeB8VREGtxkpyjikmjPMlKVwDUAHAyNmVdUPUprNzxF/5YwFGyBADPlPoA0jjR7FJ8cSI+
 1zPbRGRvXVcGeRkcabv30EjzL1IVrZaTBk4KBWDeewCg5SPnVc81nzfneYTvyCrIS0MCuNMD
 /1/FEQZa/O4YiPVGUGcumi3A26Albp9nTp4k4OcmRZSL9g6PT/YPKWOxj0ugJeSpVQ7opIct
 LcnHRXeakh0x6T7nrG03CBdK/M+EIKXdolX2dtyW380QT8fwzLjBVO0RefwygSu5Ha6XXRhg
 /K4rXvDCciI5T/cQnK5HQe0dVKGRBADd57A59PzxALhOyF7AgC4wq5m/9KbVgci2Yo4MeMFE
 uuESLYjPSSvHY/zBG6onevyYxuriSdbEgfXD10Gwvr8Exho8cX0Kg/AEDIj1zLBk3JxuTHQa
 7Rxp565Ck6cHEwIAYoWek0LzEZdMtS8BStHABFMJtlCyWMVKGXqG7Vlkdc0uR2VvcmcgTcO8
 bGxlciAoR01YLUtleSkgPGdlb3JnbXVlbGxlckBnbXgubmV0PsJaBBMRAgAaBQsHCgMEAxUD
 AgMWAgECF4AFAlU07wACGQEACgkQh5n2wOj8m8tXgACbB0On074qXrS3eWfhutFlH+6KmYIA
 oMgeY4C4cDk1/GbMBUlP2qo50EUpzsBNBD1O6ucQBAD1Jah6AjT25zOL2HdzIx0f2Uyi9f+5
 rI2FmIq4v2GCuWzpapRMEGtvr23RXjV7HJsQs7jBVFi2Xda+WmZDlviPD/T/se0Htyq09qUD
 CI+/lTnSOruyIvSlR4hKML16m7MvKwKOdU2NOkk/iCbTEoOQXM8sNKSkA14EpL7EhUCVnwAD
 BQQAtDPJPZ6prjwEtbmFaz8Me3tPfpQItg7wveW+WLtqdsvIo0qmp0hWp47t1YEVXpQVmTnx
 kBgh+8RAhlHcB7cU2MnqLDmvTh0OIn4DdusWIOfAxzv442hbFBrAA1r4xlnV2zq59E8w4hhB
 A8Tur4rfL69LfwEasPqugoI9v28ERvbCRgQYEQIABgUCPU7q5wAKCRCHmfbA6Pyby3sEAJ9H
 M3QGgjcPSRh8c7j8SN0auYvNmgCg3TiiOylY6CaDzF8iI0M6ejP5dPc=
Message-ID: <07e1f3a3-3f8d-27f2-440e-e07c64557df0@gmx.net>
Date:   Tue, 11 Sep 2018 16:11:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:yEPkN2K5s6yt47Y9REULY07qqQJl1eTw0/PACozD8BNnlYnfFpj
 DibPFvXv1+11KjUWoEx4slHPvbMjHzmyifHWhz1DIkA6FDyCvHGfGVy2NLU63IXf766MVLr
 irAcv12hT6cKQNWDN8w2n+dGZtsKquSwi6sSNvSbx34r2+YQC8PE93QABuJJHWdLbeh+2iN
 NHplJV1X3gkEzwuqQE3qw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:r3LahQpQCXE=:C8nHyZbFTPL3GqVQCjoRW1
 k/ZKuR2Awh9ZEI1qsHS5wyZjnZ6HbtomYXyPTE5HPz7vuuIAqM/uwFtIbyd1tnfjEpWu7xF7k
 3ktbfVkNEGIKjeEpVS+yn7yqfpgzOFPAKwAmKnMW06Sq49bvNlNzD8ogM+rsqtvKqOi0QG9tJ
 DCifEQU5MhFzJ3PeAxY6JLLKCAiH3zCdvj8Avnf62BO3uT5ro5q69doXZ0KgVeON4ocs/snoF
 fwPTmNRH4vFpY4n4tcD7PnkaCEBi90Vhil+ytG9NwYz0M6NbJATX6lSeOfKH7EBlAYIAWWhL0
 DzvsFMgwzjYwVrzKv7ZiX+zWzh3FuHtuKg4FCtgd2Szl8YHJ6D+JwSxYbauAlqlAlAChoZ6kB
 0mbzmGS9c1LqXRw0dLjSMHgDUmL7sdvANjJuay5W0aQVdI+bE3f0F3/EbYBNAsg5BfOhpPc/I
 khFmBmdybY3JFOPtIAnVO4yDJzpWKnyfCIu4XVIvBhtSGY+Cs2mhxcq3aaiZxu3+muKD8W/8g
 GDS4L4Rd1qk6b6i0KITNXazapFvGoEdoQkRY+9vIAbbo4t82mLOyHdLGaL9WPRPZnnzsInYN/
 Ly3XmPneQLLIIkr4kVvJqWKPI29ibq2wK9BnCHP+EDN52jRb4xin/jeL4L7KKIv3QDqC3+8fV
 5QSAjyl5gHRMDmIZIgCsPEv4RYPTPPps2SuuSzDMav9Tsj0qveXpqoNQz1veWs0X0SYmdEHZm
 FjfPLxBU4RpVrHbmA7jc7/aA3RxvQubguMk1acvodDa7cNjfrT1f8haVgALx4mVsxrJ83Mz+g
 IHXUHzfeiQpVb02daV1cSb1+GsXLkYn7A/irj1IyNpodNV5PSI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a chance of getting the two mei patches into 4.19 and 4.18.y?

https://www.spinics.net/lists/stable/msg253484.html
https://www.spinics.net/lists/stable/msg253485.html

Bugzilla entries:
https://bugzilla.kernel.org/show_bug.cgi?id=200455
https://bugzilla.redhat.com/show_bug.cgi?id=1597481

Even if maybe only a couple of systems are affected, this is causing a dead system on second suspend which could cause data loss.

Maybe the patches were not merged because of a typo in the subject (4.9 instead of 4.19)?

Best regards,
Georg
