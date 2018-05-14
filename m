Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932179AbeENNej (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 09:34:39 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:33452 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752142AbeENNeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 09:34:37 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180514133435epoutp039b2f1cf24ced3450e9430506be508677~uhjKinNEh2345423454epoutp03K
X-AuditID: b6c32a38-6f7ff7000000105c-03-5af9906b257b
Subject: Re: [FAIL bisect] Sound card probe error
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>, Inki Dae <inki.dae@samsung.com>,
        "linux-samsung-soc@vger.kernel.org"
        <linux-samsung-soc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Andrzej Hajda <a.hajda@samsung.com>
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <c62a6f86-4c6f-f7ed-f615-93d6db7412ec@samsung.com>
Date: Mon, 14 May 2018 15:34:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-version: 1.0
In-reply-to: <CAJKOXPeNJtmU2+8CdMRwXignMTetn=LScdcMspfkP3MVmTSHrg@mail.gmail.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsWy7bCmgW72hJ9RBheOs1vcWneO1WLqwyds
        FpPuT2CxOH9+A7vFpsfXWC0u75rDZjHj/D4mi7VH7rI7cHhsWtXJ5rF5Sb1H35ZVjB6fN8kF
        sERx2aSk5mSWpRbp2yVwZXyY38hecJi74nvXF/YGxsWcXYycHBICJhIbZqxm6mLk4hAS2MEo
        sfXaXnYI5zujxJx3Nxm7GDnAqpZ2JkDENzBK/Dq1ghHCuc8osbfpJDPIKGEBQ4nfnxoYQWwR
        AU2J63+/s4IUMQusZpI4eHM/C0iCDaio92gfWBGvgJ3EtzVL2UBsFgFVid9/P7OC2KICERJN
        z3+yQ9QISvyYfA+sl1MgWGLVm1tMIDYz0IIXXyaxQNjiEsfu32SEsOUlNq95ywzx22U2ia2T
        3SFsF4mfL38wQtjCEq+Ob2GH+Exa4tJRW4hwtURnWxfY9xICLYwSf6ZdYoNIWEscPn6RFWI+
        n8S7rz2sEL28Eh1tQhAlHhLtlzcxQYQdJY4cF4WEz2NmiWOLzzNPYJSbheSbWUg+mIXkg1lI
        PljAyLKKUSy1oDg3PbXYsMBErzgxt7g0L10vOT93EyM4oWhZ7GDcc87nEKMAB6MSD2/A8h9R
        QqyJZcWVuYcYJTiYlUR4dxv9jBLiTUmsrEotyo8vKs1JLT7EKM3BoiTOO0fpa5SQQHpiSWp2
        ampBahFMlomDU6qBMSFjagcr9+u1S9ZnTHEK/NOlurXxaFDmOiXlqHOL6t6w/OMTt7zKsqzi
        S8RM/pjOrf6Za1dqPSyo7+1lWnPILnbDqpkTjNT0k5PUjJObt7et83BcJL3O+vXja4GbsjZz
        zldwCDygx3SQ1y3P2uuV4AILzwe+ajULtC91WjWVarFq9swzPbdeiaU4I9FQi7moOBEA1U6X
        zyQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFLMWRmVeSWpSXmKPExsVy+t9jQd2sCT+jDK7Pl7e4te4cq8XUh0/Y
        LCbdn8Bicf78BnaLTY+vsVpc3jWHzWLG+X1MFmuP3GV34PDYtKqTzWPzknqPvi2rGD0+b5IL
        YInisklJzcksSy3St0vgyvgwv5G94DB3xfeuL+wNjIs5uxg5OCQETCSWdiZ0MXJxCAmsY5To
        /3+VBcJ5yCgxe917xi5GTg5hAUOJ358awGwRAU2J63+/s4IUMQusZpL4tbSfFaLjKbNEZ9d6
        VpAqNqCO3qN9YB28AnYS39YsZQOxWQRUJX7//QxWIyoQIXHv/Cc2iBpBiR+T77GA2JwCwRK9
        2+ayg5zHLKAuMWVKLkiYWUBc4tj9m4wQtrzE5jVvmScwCsxC0j0LoWMWko5ZSDoWMLKsYpRM
        LSjOTc8tNiowzEst1ytOzC0uzUvXS87P3cQIjIFth7X6djDeXxJ/iFGAg1GJh3fFyh9RQqyJ
        ZcWVuYcYJTiYlUR4dxv9jBLiTUmsrEotyo8vKs1JLT7EKM3BoiTOezvvWKSQQHpiSWp2ampB
        ahFMlomDU6qBMdOLceOXgFUVeVJijE/S+b8LbckRupBfca3Wy8U7wjnwfJ39GoUzykJTJx5g
        mDlx8vwciUvW30tf9WxcYOm1dquW8ax0zf8VvxSLlSMN/OTs6uu+V+n0xNy/+a/QuOfU+i/6
        qjWu/8OyBQ485jQu+Kr7JoTh7Y6uaMWokrrEfu8CMSmZbGElluKMREMt5qLiRAA50EFVfQIA
        AA==
X-CMS-MailID: 20180514133434epcas1p1cda627b4b0adae66f1cb83ba11bc44f1
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180514101728epcas4p3108760546a415b36252df93dfe38e0fb
X-RootMTR: 20180514101728epcas4p3108760546a415b36252df93dfe38e0fb
References: <CGME20180514101728epcas4p3108760546a415b36252df93dfe38e0fb@epcas4p3.samsung.com>
        <CAJKOXPfD8gZR8nZkmAr=Ldt3xESuFocQLnMtrDsNZu=ba55jcw@mail.gmail.com>
        <b193b8a0-ad25-1895-8f8d-ffab97261dc1@samsung.com>
        <CAJKOXPc+kLA+BPBmaP14zMLbbxxCmWF1eZnKoa_PcO2z9jG9JQ@mail.gmail.com>
        <4c61c422-a036-8fec-1153-d612fe5df878@samsung.com>
        <CAJKOXPc6Yj0+Z6zd-Gm-fYvfQB4rPPn0k6ED8bWScJ-tdZ=Ysw@mail.gmail.com>
        <CAJKOXPeNJtmU2+8CdMRwXignMTetn=LScdcMspfkP3MVmTSHrg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/14/2018 02:50 PM, Krzysztof Kozlowski wrote:
> On Mon, May 14, 2018 at 2:45 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> On Mon, May 14, 2018 at 2:40 PM, Sylwester Nawrocki
>> <s.nawrocki@samsung.com> wrote:
>>> On 05/14/2018 02:29 PM, Krzysztof Kozlowski wrote:
>>>> Ah, I missed these messages because I was looking at err dmesg level
>>>> (and for some reason these are warn). Anyway do you have any thoughts
>>>> how is it connected with missing Odroid XU3 sound card and max98090
>>>> codec?
>>> One reason is that the DRM driver registers an ASoC codec object which
>>> is required for the sound card registration to complete. But I wonder
>>> why there is no any error messages related to this.
>> Thanks Marek and Sylwester. Another point is that probably OOPS later
>> should not happen...

> Separate topic (trim Cc list):
> 
> ... and this means that disabling Exynos DRM causes lack of Audio. I
> tried it now and indeed without DRM there is no audio again. I think
> it is not nice... There are not many such use cases but there are
> (playing audio from console/ssh with a headless board).\

As we discussed off the mailing list, what we could probably do now
is to add a compile time dependency on CONFIG_DRM_EXYNOS_HDMI, a fallback
to the max98098 codec only when the HDMI driver is disabled. 

That might require modifying snd_soc_of_get_dai_link_codecs() so it can 
skip optional codecs.

-- 
Regards,
Sylwester
