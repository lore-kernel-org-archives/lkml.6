Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752182AbeCNSnY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 14:43:24 -0400
Received: from mail-dm3nam03on0049.outbound.protection.outlook.com ([104.47.41.49]:21298
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751651AbeCNSnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 14:43:21 -0400
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "davem@davemloft.net" <davem@davemloft.net>,
        "madalin.bucur@nxp.com" <madalin.bucur@nxp.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "leoyang.li@nxp.com" <leoyang.li@nxp.com>,
        "camelia.groza@nxp.com" <camelia.groza@nxp.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/5] DPAA Ethernet fixes
Thread-Topic: [PATCH 0/5] DPAA Ethernet fixes
Thread-Index: AQHTu5qbxOM0p3cMHESvXMs154JbO6PQEWkA
Date: Wed, 14 Mar 2018 18:43:17 +0000
Message-ID: <1521052994.4790.148.camel@infinera.com>
References: <20180314133732.24068-1-madalin.bucur@nxp.com>
In-Reply-To: <20180314133732.24068-1-madalin.bucur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Joakim.Tjernlund@infinera.com;
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BLUPR10MB0548;7:/6Zy3lWiRjVVlVu8Ub8xYkx4Unr4RVJkaA2HB0WtPNaT07sOXsSaS8c2ZJd5k3SSp1CdJjEM23/p6HJE1u4HZ4+wCQ+vqLpF9oGwcFdrFMaP6711WFk+ptyOtcqWQmtmc442Du2E6TIpKtAQIth1+5ABh5mTZBZQlXtQNWIQt+wOeigAbBgGqccJe1LPwc3yuROmHHT2G+ytYAXp+RjDwGi0oD8PrVDu0D0Kr2Xgpj3U6wkbr4QHgdzr1gZRB6MY
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: d101cb71-e9f8-4ad5-5530-08d589db73bb
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BLUPR10MB0548;
x-ms-traffictypediagnostic: BLUPR10MB0548:
x-microsoft-antispam-prvs: <BLUPR10MB05486F69D199F976649A7A82F4D10@BLUPR10MB0548.namprd10.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501244)(52105095)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:BLUPR10MB0548;BCL:0;PCL:0;RULEID:;SRVR:BLUPR10MB0548;
x-forefront-prvs: 0611A21987
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39380400002)(366004)(39850400004)(396003)(377424004)(189003)(199004)(14454004)(59450400001)(6246003)(36756003)(186003)(66066001)(305945005)(25786009)(8676002)(6512007)(4326008)(81166006)(81156014)(106356001)(8656006)(2950100002)(5660300001)(2900100001)(99286004)(53936002)(26005)(229853002)(76176011)(102836004)(6506007)(86362001)(7736002)(72206003)(2906002)(110136005)(103116003)(478600001)(54906003)(316002)(3846002)(8936002)(6116002)(2501003)(97736004)(6486002)(3280700002)(6436002)(105586002)(3660700001)(5250100002)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR10MB0548;H:BLUPR10MB0098.namprd10.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: PsMoEgPciTB/hygvmBAnVumS6xVP8WOvMS8G5DomPhQd7HdmZW5YVFr/9A+ts//0w+WxQRVML+Om7a7JMNCW/fguR2ncC1n0yyNjWiCeHgZb2qtlhl3mxYwSktowYTxGB3oH18R2GUgvcnKS3ak8CE0vNgssi0mCyeSInDE/Svjsk4TojNX9QUe8b9BLQPwt/uB4KYAOjU96QfIPVW+TeiZNGYCk2Ap+nBhUNmP+ZLjEwE35fjZoe5RdIe9s7Q4VzywNMZ4D1cvzumvjz0NwvZEyFkPysx13CVZet/fjL3J+kJ4m4FonW5OT29i+SQT+A1LqI/BSjv98fkP1Y50M7g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA9F65310B7076468398ADE8B83BA2B7@namprd10.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d101cb71-e9f8-4ad5-5530-08d589db73bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2018 18:43:17.3418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR10MB0548
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2EIhSdL003089

On Wed, 2018-03-14 at 08:37 -0500, Madalin Bucur wrote:
> Hi,
> 
> This patch set is addressing several issues in the DPAA Ethernet
> driver suite:
> 
>  - module unload crash caused by wrong reference to device being left
>    in the cleanup code after the DSA related changes
>  - scheduling wile atomic bug in QMan code revealed during dpaa_eth
>    module unload
>  - a couple of error counter fixes, a duplicated init in dpaa_eth.

hmm, some of these(all?) bugs are in stable too, CC: stable perhaps? 

> 
> Madalin
> 
> Camelia Groza (3):
>   dpaa_eth: remove duplicate initialization
>   dpaa_eth: increment the RX dropped counter when needed
>   dpaa_eth: remove duplicate increment of the tx_errors counter
> 
> Madalin Bucur (2):
>   soc/fsl/qbman: fix issue in qman_delete_cgr_safe()
>   dpaa_eth: fix error in dpaa_remove()
> 
>  drivers/net/ethernet/freescale/dpaa/dpaa_eth.c |  8 ++++----
>  drivers/soc/fsl/qbman/qman.c                   | 28 +++++---------------------
>  2 files changed, 9 insertions(+), 27 deletions(-)
> 
> --
> 2.1.0
> 
