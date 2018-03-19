Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932983AbeCSNDs convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 09:03:48 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:39488 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755426AbeCSNDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 09:03:47 -0400
From: Stefan Chulski <stefanc@marvell.com>
To: Andrew Lunn <andrew@lunn.ch>,
        Antoine Tenart <antoine.tenart@bootlin.com>
CC: Russell King - ARM Linux <linux@armlinux.org.uk>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kishon@ti.com" <kishon@ti.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>, Yan Markman <ymarkman@marvell.com>,
        "mw@semihalf.com" <mw@semihalf.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH net-next 02/10] net: phy: phylink: allow 10GKR
 interface to use in-band negotiation
Thread-Topic: [EXT] Re: [PATCH net-next 02/10] net: phy: phylink: allow 10GKR
 interface to use in-band negotiation
Thread-Index: AQHTvT77nBQG5ffkBEaqTn9C4RyF8qPXI08AgAAm5YCAABwLgIAAAhSAgAAiFzA=
Date: Mon, 19 Mar 2018 13:03:04 +0000
Message-ID: <54e290a192734831b5db22191f056a81@IL-EXCH01.marvell.com>
References: <20180316103351.16616-1-antoine.tenart@bootlin.com>
 <20180316103351.16616-3-antoine.tenart@bootlin.com>
 <20180316155307.GQ9418@n2100.armlinux.org.uk> <20180319085252.GF4519@kwain>
 <20180319111205.GB2743@n2100.armlinux.org.uk> <20180319125227.GI4519@kwain>
 <20180319125953.GD19795@lunn.ch>
In-Reply-To: <20180319125953.GD19795@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [199.203.130.14]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-19_08:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=842 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1803190153
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Andrew Lunn [mailto:andrew@lunn.ch]
> Sent: Monday, March 19, 2018 3:00 PM
> To: Antoine Tenart <antoine.tenart@bootlin.com>
> Cc: Russell King - ARM Linux <linux@armlinux.org.uk>;
> davem@davemloft.net; kishon@ti.com; gregory.clement@bootlin.com;
> jason@lakedaemon.net; sebastian.hesselbarth@gmail.com;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> thomas.petazzoni@bootlin.com; maxime.chevallier@bootlin.com;
> miquel.raynal@bootlin.com; Nadav Haklai <nadavh@marvell.com>; Stefan
> Chulski <stefanc@marvell.com>; Yan Markman <ymarkman@marvell.com>;
> mw@semihalf.com; linux-arm-kernel@lists.infradead.org
> Subject: [EXT] Re: [PATCH net-next 02/10] net: phy: phylink: allow 10GKR
> interface to use in-band negotiation
> 
> External Email
> 
> ----------------------------------------------------------------------
> Hi Antoine
> 
> > You guessed right, that's exactly my use case. The DB boards (7k and
> > 8k) have 10G interfaces without PHYs.
> 
> If they don't have PHYs, how are the connected to the outside world?
> 
>    Andrew

By external SFP or direct attached cable.

Stefan.
