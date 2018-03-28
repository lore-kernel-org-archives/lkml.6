Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753473AbeC1NvX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 09:51:23 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:61418 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751207AbeC1NvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 09:51:20 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180328135119epoutp04c813e27c0e68acca06cbdbeb66b6b6c2~gGdWO9LSA1381213812epoutp04z
X-AuditID: b6c32a45-6d3ff70000000fe4-1a-5abb9dd6cb13
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Steve Glendinning <steve.glendinning@shawell.net>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v3 3/3] video: smscufx: Delete an error message for a
 failed memory allocation in ufx_realloc_framebuffer()
Date: Wed, 28 Mar 2018 15:51:15 +0200
Message-id: <7890909.tn5kLXHESc@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <93bd62c9-4011-4abd-2a2a-3a65c692974f@users.sourceforge.net>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsWy7bCmqe61ubujDL48VLK48vU9m8X5zuXM
        FltvSVuc6PvAanF51xw2i+ZPr5gc2Dzudx9n8vjffJnFo+lUO6vH501yASxRXDYpqTmZZalF
        +nYJXBmP5x9jLvjHXNG85y1rA+N85i5GTg4JAROJU8sngdlCAjsYJR5fc+pi5AKyvzNKNO2Y
        AFc06fUEFojEbkaJ0+vvMEE4Xxkl3jb8YAepYhOwkpjYvoqxi5GDQ0TAVOLPiRCQMLPAXkaJ
        nxc4QOqFBRoZJfpm7gebyiKgKrHw0HJGEJtXQFOi/fs0JhBbVMBLYsu+djCbU8BT4n7nS6ga
        QYkfk++xQAyVl9i3fyorhK0jcfbYOkaQBRICW9gkVh48xQZxtotEw9wedghbWOLV8S1QtrTE
        s1UboRqaGSW+7dgD9ecERok964UgbGuJw8cvQm3gk+g4/Jcd5DMJAV6JjjaoEg+JKWsPskCE
        HSVebQiEBMptRolfs36xTmCUnYXk7llI7p6F5O4FjMyrGMVSC4pz01OLjQoM9YoTc4tL89L1
        kvNzNzGC04GW6w7GGed8DjEKcDAq8fAWxOyKEmJNLCuuzD3EKMHBrCTC+15jd5QQb0piZVVq
        UX58UWlOavEhRmkOFiVx3rYAlyghgfTEktTs1NSC1CKYLBMHp1QD44WfL8I6k02uTXsbuO73
        mUtf+evYM2QeH7u0o/hUapSEtNXRN9LGmbtVmszFnvFftNpSt36BdHXqoycdfRp3mBXuRO6e
        6Xr7m3Pmt9TV7yJUW7lvv+N9MCV97nyJSR8OnTFkK91UsYH1k9ZUyyfPrPfXTvl4e9n9Fhvn
        yKrfziFawc++fTj+yVqJpTgj0VCLuag4EQCFoZKMAwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsVy+t9jAd2rc3dHGcxoU7e48vU9m8X5zuXM
        FltvSVuc6PvAanF51xw2i+ZPr5gc2Dzudx9n8vjffJnFo+lUO6vH501yASxRXDYpqTmZZalF
        +nYJXBmP5x9jLvjHXNG85y1rA+N85i5GTg4JAROJSa8nsHQxcnEICexklGjtus0O4XxllLh2
        5xQTSBWbgJXExPZVjF2MHBwiAqYSf06EgNQwC+xllPjUfZUVxBEWaGSU6Ju5H2wsi4CqxMJD
        yxlBbF4BTYn279PABokKeEls2dcOZnMKeErc73zJCLHtLqPEtC+dzBANghI/Jt9jAbGZBeQl
        9u2fygpha0ms33mcaQIj/ywkZbOQlM1CUraAkXkVo2RqQXFuem6xUYFRXmq5XnFibnFpXrpe
        cn7uJkZgEG87rNW/g/HxkvhDjAIcjEo8vAUxu6KEWBPLiitzDzFKcDArifC+19gdJcSbklhZ
        lVqUH19UmpNafIhRmoNFSZyXP/9YpJBAemJJanZqakFqEUyWiYNTqoHxiEL55jOzOaYeW8v2
        yPvY5TVmX32fiT7sjLu+QqczNj3BTut2Rab8MYNghY4tcY2P7JvNKkpvmZge8vCa9EU5OWjp
        navbHrZKPi7yDzWyzFiv2hR8n18l4r2r4dTj3rOvCvXcyk9Y3ye6zXWHnLivtdLiuZwTZtuV
        9f/scLObJrzKMPLNSn0lluKMREMt5qLiRADYp8eGXgIAAA==
X-CMS-MailID: 20180328135117epcas2p24d5a1113b24811992fc4df1a1002af84
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20171125204312epcas2p149d6487ac83e886f95aefe0b35aef1b0
X-RootMTR: 20171125204312epcas2p149d6487ac83e886f95aefe0b35aef1b0
References: <CGME20171125204312epcas2p149d6487ac83e886f95aefe0b35aef1b0@epcas2p1.samsung.com>
        <a36fa112-40a1-703c-c2ac-ce7e88bb8609@users.sourceforge.net>
        <93bd62c9-4011-4abd-2a2a-3a65c692974f@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, January 07, 2018 05:06:13 PM SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 7 Jan 2018 16:12:40 +0100
> 
> Omit an extra message for a memory allocation failure in this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Patch queued for 4.17, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
