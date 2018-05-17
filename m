Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752466AbeEQO3V (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 10:29:21 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49414 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751930AbeEQO3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 10:29:20 -0400
Date: Thu, 17 May 2018 10:29:05 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Oleksandr Andrushchenko <andr2000@gmail.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        xen-devel@lists.xenproject.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, jgross@suse.com, lyan@suse.com,
        andrii_chepurnyi@epam.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: Re: [PATCH v3 2/2] Input: xen-kbdfront - allow better run-time
 configuration
Message-ID: <20180517142905.GF12679@char.us.oracle.com>
References: <20180514144029.16019-1-andr2000@gmail.com>
 <20180514144029.16019-2-andr2000@gmail.com>
 <20180516171528.GD21971@dtor-ws>
 <e9882c52-3641-7c32-1f64-dd9c4f35de5f@gmail.com>
 <20180516210817.GF21971@dtor-ws>
 <7cecb5d1-5cd3-b63d-d6eb-d1e2dfba9ca6@gmail.com>
 <d35b6720-62e3-e9d4-dbe5-a04d75dde0b7@oracle.com>
 <60ed5392-eff6-be1c-f092-bb93184db060@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60ed5392-eff6-be1c-f092-bb93184db060@gmail.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8895 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=654
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805170133
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 04:09:04PM +0300, Oleksandr Andrushchenko wrote:
> On 05/17/2018 04:08 PM, Boris Ostrovsky wrote:
> > On 05/17/2018 01:31 AM, Oleksandr Andrushchenko wrote:
> > > I will go with the change you suggested and
> > > I'll send v4 tomorrow then.
> > 
> > 
> > Please make sure your changes to kbdif.h are in Xen first. I believe you
> > submitted a patch there but I don't see it in the staging tree yet.
> Sure, I already have Release ack for the one which is not
> in Xen tree yet, hope Konrad can apply it today,
> so tomorrow Xen and Linux are both ok (or by the time

It is checked in (on the Xen tree).
> I send v4).
> > -boris
> Thank you,
> Oleksandr
