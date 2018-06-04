Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752048AbeFDJRm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 05:17:42 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:10933 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751097AbeFDJRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 05:17:40 -0400
X-IronPort-AV: E=Sophos;i="5.49,476,1520870400";
   d="scan'208";a="79541898"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "sayalil@codeaurora.org" <sayalil@codeaurora.org>,
        "evgreen@chromium.org" <evgreen@chromium.org>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "subhashj@codeaurora.org" <subhashj@codeaurora.org>,
        "vivek.gautam@codeaurora.org" <vivek.gautam@codeaurora.org>,
        "rnayak@codeaurora.org" <rnayak@codeaurora.org>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V1 2/3] scsi: ufs: Add ufs provisioning support
Thread-Topic: [PATCH V1 2/3] scsi: ufs: Add ufs provisioning support
Thread-Index: AQHT+ZV8LwV2jXWcrUCFiM3Chg401KRP1pSA
Date: Mon, 4 Jun 2018 09:17:37 +0000
Message-ID: <39ab956b95a645c6e63eb9713ea9547fdc265a22.camel@wdc.com>
References: <1527849774-7623-1-git-send-email-sayalil@codeaurora.org>
         <1527849774-7623-3-git-send-email-sayalil@codeaurora.org>
In-Reply-To: <1527849774-7623-3-git-send-email-sayalil@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [178.117.55.239]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0366;7:3pPzFqkw+lnJyy2L+73DJPdAHfftpsiMtJ8ywo62BYbb0O5x19BW1DtDHXEHN8se8AMNnSlolpesNg2SEkpxhQyuY/rtZAiW0iF9rn8h5cwaZjVP6LHOWuKmq4i/8SwLNeVZxmZAA9ZUqFtRFR+M/G90I0arTy/MNlX+1SSCoss39euOdbmbtRozJ5bctdKPBuZAeoTkEmfYFEvDiVEUT0HpczBo8+1TPAe93uMwT5AJHIkB0eW3QlNFWVo6E0LC;20:hYVRJ4kysLmH8UV+w2mdemZLCCzBh0O+3MTb99OKsJ/c1tbwCljJFLNr15TajujQ4THlGNSDKQYe7sJz+YKtfUtJp2bcULK1SSztFZHupq6wAngD2BKEvjaE9SDt15aCbBHTMw3HVK4KHGOMRJ6JWohcIluemes/42mcjTvAUkU=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0366;
x-ms-traffictypediagnostic: MWHPR04MB0366:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0366FFDC0103E62234D4A4E298670@MWHPR04MB0366.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0366;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0366;
x-forefront-prvs: 069373DFB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(346002)(39380400002)(396003)(366004)(199004)(189003)(2900100001)(66066001)(6436002)(478600001)(3660700001)(229853002)(99286004)(54906003)(305945005)(102836004)(81156014)(81166006)(14454004)(72206003)(5660300001)(6486002)(68736007)(186003)(105586002)(486006)(6246003)(110136005)(316002)(2501003)(7736002)(6116002)(8936002)(97736004)(8676002)(26005)(5250100002)(106356001)(7416002)(53936002)(36756003)(6512007)(3846002)(2201001)(25786009)(39060400002)(4326008)(575784001)(2616005)(476003)(118296001)(6506007)(86362001)(76176011)(3280700002)(2906002)(11346002)(446003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0366;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: KgGDkODUdYZPjwVNph2YdCqLzbXSRjbI7GGy38gyqAP1qo8mmFL36rtZ5sL/vDAI4jPrAhU4LV3u/tHrzHd3AyXkRaJW94pErsI0XcXjipq+ZZ7WIcE36IYg2sp6C6TzLjFk8MhoP/fBZ2yr4dl6ATM+dNm3nHhRK3d/olBW7oQzyUxdRQNlHeVwcQY+UnUW
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <5937082202E2A044B788E888E214C35D@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 71dd7933-4c3c-4fdd-0b5b-08d5c9fc03f0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71dd7933-4c3c-4fdd-0b5b-08d5c9fc03f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2018 09:17:37.6547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0366
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w549HnFg032458

On Fri, 2018-06-01 at 16:12 +0530, Sayali Lokhande wrote:
> +	qTotalRawDeviceCapacity =
> +		(uint64_t)geo_buf[0x0b] | ((uint64_t)geo_buf[0x0a] << 8) |
> +		((uint64_t)geo_buf[0x09] << 16) |
> +		((uint64_t)geo_buf[0x08] << 24) |
> +		((uint64_t)geo_buf[0x07] << 32) |
> +		((uint64_t)geo_buf[0x06] << 40) |
> +		((uint64_t)geo_buf[0x05] << 48) |
> +		((uint64_t)geo_buf[0x04] << 56);
> +	wEnhanced1CapAdjFac =
> +		(uint16_t)geo_buf[0x31] | ((uint16_t)geo_buf[0x30] << 8);

Please use get_unaligned_be*() instead of open-coding these functions.

> +		*pt++ = (cfg->unit[i].dNumAllocUnits >> 24) & 0xff;
> +		*pt++ = (cfg->unit[i].dNumAllocUnits >> 16) & 0xff;
> +		*pt++ = (cfg->unit[i].dNumAllocUnits >> 8) & 0xff;
> +		*pt++ = (cfg->unit[i].dNumAllocUnits) & 0xff;

Please use put_unaligned_be() instead of open-coding this function.

Thanks,

Bart.
