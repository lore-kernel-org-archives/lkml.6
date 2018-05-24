Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968990AbeEXLb7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 07:31:59 -0400
Received: from mail-he1eur01on0068.outbound.protection.outlook.com ([104.47.0.68]:15930
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S968901AbeEXLb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 07:31:56 -0400
From: Andy Duan <fugang.duan@nxp.com>
To: YueHaibing <yuehaibing@huawei.com>,
        "davem@davemloft.net" <davem@davemloft.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] net: fec: remove stale comment
Thread-Topic: [PATCH net-next] net: fec: remove stale comment
Thread-Index: AQHT81I5OitL6XNSIEus7oysAX4eM6Q+vrhQ
Date: Thu, 24 May 2018 11:31:53 +0000
Message-ID: <AM4PR0401MB226080C07E16578298F1E4E5FF6A0@AM4PR0401MB2260.eurprd04.prod.outlook.com>
References: <20180524112707.3580-1-yuehaibing@huawei.com>
In-Reply-To: <20180524112707.3580-1-yuehaibing@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fugang.duan@nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM4PR0401MB1730;7:iJOry3DFaQBYjRGm2X7akI1NpqyrNrDlfpSIhx7nM8j9Xt+v+mmTauWoo164PNx5wGp985CkyrKS/WMW6D1nS5HGInhjyaRjLT9LTKydAg8A4Lt6+LYajFCL/bwJNPPdoVMetMXP3bYOG5zhBPxWpb5wgcOQRM4HCB/I7pkl8gS9S5G61EJ2wwlLnxWfNdmUHdeY0bB8J+eYt/oeA/8NpucHuGDfO28yWOFinmQHwDQUiVKEgrmp/odVhR27h7go
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM4PR0401MB1730;
x-ms-traffictypediagnostic: AM4PR0401MB1730:
x-microsoft-antispam-prvs: <AM4PR0401MB173014FB079CABBD61E54A40FF6A0@AM4PR0401MB1730.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(50582790962513)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM4PR0401MB1730;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0401MB1730;
x-forefront-prvs: 0682FC00E8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(366004)(376002)(396003)(346002)(189003)(199004)(26005)(476003)(6436002)(11346002)(102836004)(186003)(66066001)(486006)(99286004)(97736004)(446003)(6116002)(3846002)(478600001)(68736007)(229853002)(316002)(2900100001)(575784001)(86362001)(7736002)(74316002)(5660300001)(305945005)(5250100002)(8676002)(14454004)(33656002)(2501003)(2906002)(9686003)(3660700001)(55016002)(105586002)(106356001)(3280700002)(53936002)(25786009)(76176011)(6506007)(7696005)(54906003)(4326008)(8936002)(81166006)(81156014)(110136005)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0401MB1730;H:AM4PR0401MB2260.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: boSnmvLvK8uzDlcVaNrs3XXqAVz4YjZkfd4ZrdgTVt/qLisgf1avUWeuOVqpz2pQ13Hty39FCRyxcZlqUc+CkO5rWCt597E6ZRLuO/KQ5v1VafQXtMvTGVn7C1TQ5JPth382SD/utPajeHAvjLaq4LNmQKe67eS+wBAD3GBzELIAAwQb9iQ897hPUdYj/bkq
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 47465410-f1d8-4fdc-1706-08d5c169f2fa
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47465410-f1d8-4fdc-1706-08d5c169f2fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2018 11:31:53.3902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB1730
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4OBWJAK019987

> From: YueHaibing <yuehaibing@huawei.com> Sent: 2018Äê5ÔÂ24ÈÕ 19:27
> This comment is outdated as fec_ptp_ioctl has been replaced by
> fec_ptp_set/fec_ptp_get since commit 1d5244d0e43b ("fec: Implement
> the SIOCGHWTSTAMP ioctl")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thanks.
Acked-by: Fugang Duan <fugang.duan@nxp.com>
> ---
>  drivers/net/ethernet/freescale/fec_ptp.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fec_ptp.c
> b/drivers/net/ethernet/freescale/fec_ptp.c
> index f814397..d438ef8 100644
> --- a/drivers/net/ethernet/freescale/fec_ptp.c
> +++ b/drivers/net/ethernet/freescale/fec_ptp.c
> @@ -466,12 +466,6 @@ static int fec_ptp_enable(struct ptp_clock_info
> *ptp,
>  	return -EOPNOTSUPP;
>  }
> 
> -/**
> - * fec_ptp_hwtstamp_ioctl - control hardware time stamping
> - * @ndev: pointer to net_device
> - * @ifreq: ioctl data
> - * @cmd: particular ioctl requested
> - */
>  int fec_ptp_set(struct net_device *ndev, struct ifreq *ifr)  {
>  	struct fec_enet_private *fep = netdev_priv(ndev);
> --
> 2.7.0
> 
