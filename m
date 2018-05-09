Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966035AbeEIXVo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 19:21:44 -0400
Received: from mail-ve1eur01on0054.outbound.protection.outlook.com ([104.47.1.54]:9893
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965902AbeEIXVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 19:21:43 -0400
From: Saeed Mahameed <saeedm@mellanox.com>
To: "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        Israel Rukshin <israelr@mellanox.com>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        Max Gurtovoy <maxg@mellanox.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>,
        Matan Barak <matanb@mellanox.com>
Subject: Re: linux-next: Tree for May 9 (mlx5)
Thread-Topic: linux-next: Tree for May 9 (mlx5)
Thread-Index: AQHT56rSwIoZBmtkfEWKuAfr8oM2BqQoCZ0A
Date: Wed, 9 May 2018 23:21:39 +0000
Message-ID: <1525908096.19800.3.camel@mellanox.com>
References: <20180509212133.41a59f2f@canb.auug.org.au>
         <826ab15b-f2bc-0c5d-8d5e-6466badcd3e0@infradead.org>
In-Reply-To: <826ab15b-f2bc-0c5d-8d5e-6466badcd3e0@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=saeedm@mellanox.com;
x-originating-ip: [2601:647:4000:4586::50a1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0502MB2903;7:uqHqwIbmPXNeW5bJZ3qUq1l9U/Cw8cr67SNwvma1WH7b4Ab85bMqEpD21q+uDP72qBHXYjZO1lPleueMdoH6xkNAz8WVRt0XI0jqEB4Za2bM1W0syrznd9n4bL61iYtUUVwkyZ623FBnzfYRcamhvFCYPfR4Ad+StqOQk5u/g5Q0h7aYnde6nrguYaLRGQ9WH97dTdseUXVUxIeKIIm9rC49De406FIK7jHvmejJMOXgFv5YWqTyGT1++p6Pf64E
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0502MB2903;
x-ms-traffictypediagnostic: DB6PR0502MB2903:
x-microsoft-antispam-prvs: <DB6PR0502MB2903DDECE8D05689B58CB8F7BE990@DB6PR0502MB2903.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:DB6PR0502MB2903;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0502MB2903;
x-forefront-prvs: 0667289FF8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(39380400002)(346002)(396003)(366004)(199004)(189003)(377424004)(53754006)(102836004)(2900100001)(106356001)(11346002)(2501003)(446003)(476003)(53936002)(54906003)(97736004)(316002)(110136005)(5660300001)(6506007)(53546011)(186003)(46003)(76176011)(99286004)(86362001)(25786009)(5250100002)(486006)(2616005)(3280700002)(81166006)(68736007)(3660700001)(6116002)(2906002)(81156014)(36756003)(6436002)(7736002)(8676002)(6636002)(478600001)(50226002)(6512007)(107886003)(6246003)(4326008)(305945005)(105586002)(229853002)(103116003)(6486002)(8936002)(14454004)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0502MB2903;H:DB6PR0502MB2901.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 7XGPwdqNus/PLotAo/WUeLABHZ+2OV44BfiYOF+8XGfolE2H8OTqPPnX5GONUQH6jrNm76076K/1vAwHn+ji5Af2Z8eI2Z3bTMVcRctwu7Hvt5F2zD6BL9DyfTgrqzZMzuxG8jsLkUeAPJEMArGuz8WTzCIy9UtrxpPxmhC98b+Js1t+jlRv/6oING2CSNY9
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <52EF7AE0E693B34EA321511E8EC69DFA@eurprd05.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 63655e00-7b36-4e44-bbd0-08d5b6039e15
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63655e00-7b36-4e44-bbd0-08d5b6039e15
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2018 23:21:39.4612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0502MB2903
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w49NLrQR013719

On Wed, 2018-05-09 at 08:31 -0700, Randy Dunlap wrote:
> On 05/09/2018 04:21 AM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20180508:
> > 
> 
> on x86_64:
> # CONFIG_SMP is not set
> 
> In file included from
> ../drivers/net/ethernet/mellanox/mlx5/core/main.c:43:0:
> ../include/linux/mlx5/driver.h: In function
> 'mlx5_get_vector_affinity_hint':
> ../include/linux/mlx5/driver.h:1299:13: error: 'struct irq_desc' has
> no member named 'affinity_hint'
>   return desc->affinity_hint;
>              ^
> 
> 

Hi Stephen,

Israel and Max are working on a solution, will provide it ASAP.

Thanks,
Saeed.
