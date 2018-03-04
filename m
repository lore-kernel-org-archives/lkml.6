Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932246AbeCDJdN convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 04:33:13 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:54014 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932179AbeCDJdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 04:33:10 -0500
From: Stefan Chulski <stefanc@marvell.com>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
CC: Antoine Tenart <antoine.tenart@bootlin.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Yan Markman <ymarkman@marvell.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>, "mw@semihalf.com" <mw@semihalf.com>
Subject: RE: [PATCH net-next 3/5] net: mvpp2: use a data size of 10kB for Tx
 FIFO on port 0
Thread-Topic: [PATCH net-next 3/5] net: mvpp2: use a data size of 10kB for Tx
 FIFO on port 0
Thread-Index: AQHTsj192xJjJ5DFzUShqEYMfMH8kaO8/C6AgAKgx/CAABJ0AIAAIbwA
Date: Sun, 4 Mar 2018 09:33:01 +0000
Message-ID: <e4401911afa749949b9f478c65e887cc@IL-EXCH01.marvell.com>
References: <20180302154044.25204-1-antoine.tenart@bootlin.com>
        <20180302154044.25204-4-antoine.tenart@bootlin.com>
        <20180302171117.2344a893@windsurf.lan>
        <bd3a0e716e1c44938b7a216ea54b9c7e@IL-EXCH01.marvell.com>
 <20180304102518.1963cb8a@windsurf.home>
In-Reply-To: <20180304102518.1963cb8a@windsurf.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.5.102.207]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-04_05:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=694 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1803040121
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Thomas Petazzoni [mailto:thomas.petazzoni@bootlin.com]
> Sent: Sunday, March 04, 2018 11:25 AM
> To: Stefan Chulski <stefanc@marvell.com>
> Cc: Antoine Tenart <antoine.tenart@bootlin.com>; davem@davemloft.net;
> Yan Markman <ymarkman@marvell.com>; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; maxime.chevallier@bootlin.com;
> gregory.clement@bootlin.com; miquel.raynal@bootlin.com; Nadav Haklai
> <nadavh@marvell.com>; mw@semihalf.com
> Subject: Re: [PATCH net-next 3/5] net: mvpp2: use a data size of 10kB for Tx
> FIFO on port 0
> 
> Hello,
> 
> On Sun, 4 Mar 2018 06:29:59 +0000, Stefan Chulski wrote:
> 
> > > Is there a reason to hardcode 10KB for port 0, and 3KB for the other ports
> ?
> > > Would there be use cases where the user may want different
> > > configurations ?
> >
> > Design requirement are 10KB TX FIFO for the 10Gb/sec and 2.5KB for the
> 2.5Gb/sec.
> 
> What is a "design requirement" ? Is it a HW design limitation ?

We can call it HW design limitation. Anyway to support 10Gb/sec port should have at least 10KB TX FIFO.

> So, the limitation has nothing to do with CP110 really, it's just a limitation of
> PPv2.2, and mentioning CP110 in the comment doesn't make much sense,
> correct ?

I will change it.

Stefan.
