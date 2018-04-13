Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754353AbeDMLVx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 07:21:53 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:54533 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753981AbeDMLVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 07:21:51 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180413112149epoutp02053cf19a1487c050cd44c6b1f8ec0508~k_vYrotJR1594215942epoutp02F
X-AuditID: b6c32a38-d73ff70000001082-60-5ad092cc3ed1
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "Li, Philip" <philip.li@intel.com>
Subject: Re: [GIT PULL] Thermal management updates for v4.17-rc1
Date: Fri, 13 Apr 2018 13:21:45 +0200
Message-id: <5312146.KITRp36PIx@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <2093381.eDLEWQi9DB@amdc3058>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsWy7bCmnu7ZSReiDLptLOZ9lrWYf+Uaq8Xl
        XXPYLD73HmG0uHToIpPFk4d9bBaP+t6yO7B77Jx1l91j8Z6XTB53ru1h8zgx4zeLx+dNcgGs
        UVw2Kak5mWWpRfp2CVwZGxurC5YJVczZN4O5gfEfbxcjJ4eEgInE0kt7mbsYuTiEBHYwSjQf
        /swK4XxnlJi0aQkrTNW3he8ZIRK7GSWOzN7LBOF8ZZQ4fP4BG0gVm4CVxMT2VYwgtohAhMTB
        tRBFzAKnGCUmLp/GDpIQFnCQaNhwjQXEZhFQlZiyfBUziM0roClxY+8hsEGiAl4SW/a1M4HY
        nAJaEj+erGSBqBGU+DH5HpjNLCAvsW//VFYIW0fi7LF1YOdJCBxgk1jaP4ER4m4XicPrWlkg
        bGGJV8e3AB3BAWRLS1w6agtR38wo8W3HHmaImgmMEnvWC0HY1hKHj1+EWsAn8e5rDytEL69E
        RxtUiYdEy5JNTBBhR4mdF8C2CgkcZpRY8cF6AqPsLCRXz0Jy9SwkVy9gZF7FKJZaUJybnlps
        WGCiV5yYW1yal66XnJ+7iRGcHrQsdjDuOedziFGAg1GJh1eh8nyUEGtiWXFl7iFGCQ5mJRHe
        mwUXooR4UxIrq1KL8uOLSnNSiw8xSnOwKInzPvU5EyUkkJ5YkpqdmlqQWgSTZeLglGpgFIzY
        k6v7e2va+uSjv97YMP1sVxCaUy007VXLKXPfgwLb9pnHSjX6C27ftjTKa8nCCJlvd8tfz+wp
        WL/d5Xy1+7Z4g8+KnI+k7k+b9OjZi8dHLc4nFj2bffB4S5XVL9OJNdJT237tahN6Z2yZ2s3U
        Ilbx9MLtE8p7zGda5yxLPdbLJHBctOJikRJLcUaioRZzUXEiAOW5mHALAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsVy+t9jAd0zky5EGRy6JGIx77Osxfwr11gt
        Lu+aw2bxufcIo8WlQxeZLJ487GOzeNT3lt2B3WPnrLvsHov3vGTyuHNtD5vHiRm/WTw+b5IL
        YI3isklJzcksSy3St0vgytjYWF2wTKhizr4ZzA2M/3i7GDk5JARMJL4tfM/YxcjFISSwk1Hi
        yKL5TBDOV0aJrpnnmECq2ASsJCa2r2IEsUUEIiT23JkK1sEscIZRYs/aR+wgCWEBB4mGDddY
        QGwWAVWJKctXMYPYvAKaEjf2HmIDsUUFvCS27GsHG8opoCXx48lKsHohgXyJS1enM0HUC0r8
        mHwPLM4sIC+xb/9UVghbS2L9zuNMExj5ZyEpm4WkbBaSsgWMzKsYJVMLinPTc4uNCgzzUsv1
        ihNzi0vz0vWS83M3MQKDetthrb4djPeXxB9iFOBgVOLhVag8HyXEmlhWXJl7iFGCg1lJhPdm
        wYUoId6UxMqq1KL8+KLSnNTiQ4zSHCxK4ry3845FCgmkJ5akZqemFqQWwWSZODilGhiFZXJK
        7tfwN57PvnTc+mzWQam7O7jrLfY4SRRZ3vqyc9b7O6tuf9KZPU3xwf+V0T2RTtfag6S1zvJz
        CjQVSzD1/biyeW3vNV4jxlN6Bhfyey3n5AsnS01JEH9TMZPXntH/zDN396YrCxa8SIrxc3q9
        cVtZ5+37T5Yl+y0y2S8+te9ObsK8G3uVWIozEg21mIuKEwEM08jUZgIAAA==
X-CMS-MailID: 20180413112148epcas1p3f657cb50af4151d41f8c404e6b0d5fab
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180413112148epcas1p3f657cb50af4151d41f8c404e6b0d5fab
X-RootMTR: 20180413112148epcas1p3f657cb50af4151d41f8c404e6b0d5fab
References: <1523436077.16235.5.camel@intel.com>
        <10298074.ogKH1ypqfx@amdc3058> <2093381.eDLEWQi9DB@amdc3058>
        <CGME20180413112148epcas1p3f657cb50af4151d41f8c404e6b0d5fab@epcas1p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, April 13, 2018 01:12:39 PM Bartlomiej Zolnierkiewicz wrote:
> On Friday, April 13, 2018 12:41:18 PM Bartlomiej Zolnierkiewicz wrote:
> > On Friday, April 13, 2018 12:30:04 PM Daniel Lezcano wrote:
> > > On 13/04/2018 11:28, Bartlomiej Zolnierkiewicz wrote:
> > > 
> > > [ ... ]
> > > 
> > > >>> It is okay to return 0 because this code-path (the default one) will be
> > > >>> never hit by the driver (probe makes sure of it) - the default case is
> > > >>> here is just to silence compilation errors..
> > > >>
> > > >> The init function is making sure cal_type is one or another. Can you fix
> > > >> it correctly by replacing the 'switch' by a 'if' instead of adding dead
> > > >> branches to please gcc?
> > > >>
> > > >> if (data->cal_type == TYPE_TWO_POINT_TRIMMING) {
> > > >> 	return ...;
> > > >> }
> > > >>
> > > >> return ...;
> > > > 
> > > > I'm not the one that added this switch statement (it has been there since
> > > > 2011) and I would be happy to remove it. 
> > > 
> > > Actually the switch statement was fine until the cleanup.
> > 
> > I don't see how it was fine before as the driver has never used the default
> > case (always used TYPE_ONE_POINT_TRIMMING or TYPE_TWO_POINT_TRIMMING).
> > 
> > Could you please explain this more?
> > 
> > > > However could we please defer
> > > > this to v4.17 and merge the current set of Exynos thermal fixes/cleanups
> > > > (they simplify the driver a lot and make ground for future changes)?
> > > 
> > > Regarding the latest comment, this can be fixed properly by 'return' (or
> > > whatever you want which does not get around of gcc warnings).
> > 
> > Do you mean that you want the patch with switch statement removal?
> > 
> > Is incremental fix OK or do you want something else?
> 
> Danial has already posted it, I hope the fix is fine with you.

should have been:

Eduardo: Daniel has already posted it, I hope the fix is fine with you.

(& sorry for the typo)

> Also sorry for the delay with handling issue - I was on holiday last two
> days and for some reason I was under (wrong) impression that the previous
> fix has been in thermal tree (so I was quite surprised today reading this
> mail thread).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
