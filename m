Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751948AbeBZAtt (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 19:49:49 -0500
Received: from mail-cys01nam02on0132.outbound.protection.outlook.com ([104.47.37.132]:63520
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751904AbeBZAtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 19:49:46 -0500
Authentication-Results: spf=pass (sender IP is 117.103.190.42)
 smtp.mailfrom=sony.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=sony.com;
From: <Yasunari.Takiguchi@sony.com>
To: <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-media@vger.kernel.org>
CC: <tbird20d@gmail.com>, <frowand.list@gmail.com>,
        <Masayuki.Yamamoto@sony.com>, <Hideki.Nozawa@sony.com>,
        <Kota.Yonezawa@sony.com>, <Toshihiko.Matsumoto@sony.com>,
        <Satoshi.C.Watanabe@sony.com>, <Yasunari.Takiguchi@sony.com>
Subject: RE: [PATCH v5 00/12] [dt-bindings] [media] Add document file and
 driver for Sony CXD2880 DVB-T2/T tuner + demodulator
Thread-Topic: [PATCH v5 00/12] [dt-bindings] [media] Add document file and
 driver for Sony CXD2880 DVB-T2/T tuner + demodulator
Thread-Index: AQHTkDdlSlnytHe3d0i/wecu1oCfQqO2FWfw
Date: Mon, 26 Feb 2018 00:49:41 +0000
Message-ID: <02699364973B424C83A42A84B04FDA8546D016@JPYOKXMS113.jp.sony.com>
References: <20180118084016.20689-1-Yasunari.Takiguchi@sony.com>
In-Reply-To: <20180118084016.20689-1-Yasunari.Takiguchi@sony.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:cf8:1:aec:0:dddd:6f26:e2ba]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:117.103.190.42;IPV:NLI;CTRY:JP;EFV:NLI;SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(346002)(39380400002)(2980300002)(438002)(199004)(189003)(8676002)(76176011)(47776003)(7696005)(50466002)(102836004)(186003)(336011)(26005)(77096007)(6116002)(23726003)(2906002)(8936002)(55846006)(39060400002)(2900100001)(2920100001)(86152003)(55016002)(2201001)(106466001)(86362001)(478600001)(33656002)(7636002)(229853002)(7736002)(558084003)(2950100002)(72206003)(305945005)(316002)(16586007)(54906003)(110136005)(106002)(107886003)(2876002)(4326008)(5660300001)(6246003)(356003)(46406003)(246002)(97756001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1467;H:jp.sony.com;FPR:;SPF:Pass;PTR:jpyokxeg102.jp.sony.com;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT044;1:BB+dgp4CDBg6yl5UvL/hDKQHmrQNLhxmff8+Bkv9tDI58Ln6kDfyzapueuMNXoBVkL9Dvqa5Q12qblng63jdVOzC3bjC1Zj00lqR8My9ptnQtpwtZmtBLrQsEeJBLEb7
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1dfedbe9-1948-469e-69c0-08d57cb2d3e1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(4608076)(2017052603307)(7193020);SRVR:DM5PR13MB1467;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR13MB1467;3:jxQfY1GGRS9bcBxCJfdvbzthToSWEPejd6easj31BoFrxpLm0DtK7L6R7NZCoMtrVGKNwtsB/iIn4CFVVPyuTmIUbl+LwFjCvLPzk3YqUMN6TSrpt+sZMsxhCtQVNIoo3hqO1wGV8pn0vvN9hlSWvTY7/GE1ToFfADYmv3SIHXfsHZnJvf9W9UaLOPw2unl4gPVgkS3H/YCj35J4mT5C7EI4WlvH/UhErSN0Oh4+NQb0eJzjbicPZmQNK0qjCcruqZ2yk4F3X6MvdBP5YdyIzmOf+Ctq8bXkLBG0SM11ysTnFqU6bpQ7Q1+CwDCt+elyHUDJ0dpRzex5CiJ6wdtF+P9xVtpXTgg9xvlh2G5y3PU=;25:PR+3/EzycqjMz6GnTEDlPh0lctOJKA/cM7PsYrAEa8q4lVMu3m13hTIqbCLw/TILRqp5QTf5jMNKOW/vV9f5LFJmdxFcEwhU63OsJJoH42R05JID1O8aXoL+2+XiLJ8nXXkWvSTpXzV3W6LHyxl+P4rzXkGIlW67QH/lDchgPECekkLlFEARz2OIAlEzf49wGRGHgBWWqHE1rI2FJ8rVKxTQVTaVdkc/3FZdy0fG3zF+ZHPcazB0iomZjpXikazD17Q9aZaGI+5xngdg0nwaP2qGHVdQbT5GDzjQglR8REKSSBtqKBWz/0yYT+YUF+VULnhmFZLQKgPqBSEyLCg9Yw==
X-MS-TrafficTypeDiagnostic: DM5PR13MB1467:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR13MB1467;31:/R11kN5RfOedtvj5D4utqFXaOWeSulBubmgkPfn/jdR0zBn4M3f40xGIVOSdy+ws77IRjZqFt6x/EUAFvw3Mg5+gvZLO15jG5d0tjbI9bpaXx437jJjLKaoFVZ9alooeXnUf9DrTDlYuh107UzfkQLU9UYWfeDXSUS5FwTjzOPTZ9OkPx1dTh5fhnvDpeoC2ShXZAbSh6fCuBbzvqOl4Cns2w5DobkBsW67dyy7Cg9k=;20:spfBUkMDnTRt7gTmI6DBP2FQtB3+VpcjjeAm2pv69D77ibC6bkEPI8Sow636o4fBG7FJNlFLPnzl+DwW4hFRVUdvGK6yL4762Ih+HP8rB8VBjQD71ODp/vmZiu/zP/rDPck9jVoEXWdtw8DxwxoDL6BHTrLHc6wRRlxqQNLIcU4QXx/FcHjLTN0sZEaFidUZtPPzZIXhkByw62i8jX1c1scS91cUSFFFqK+sHyCcZO7nUeuGG0Jzwq4a5MKbRsyygSb5SC1A8QcIYYWVDSCDguXY2YkbA817ltHftIv7ebX60MFelXpdSKs28k77X5VqpgRoUUZJFFJfuZbdVn49pQgqmMdeAAvsqr+UU6x3kugskEGnfFJG2xP8C+mYizG9WXIMTuVa8Z7r55ThfGHAjWnvUjBI3z6zjPM3/PI2CVY/tR8IMWMgtAid7uIe5ySyUXZSt3d3cJlR8RoIAnTpWJLIhc0rl85H3p96E298nNh5sqmEgHdGw8F0wpdK8uat
X-Microsoft-Antispam-PRVS: <DM5PR13MB14679523F5AE4D7EE21B019CFDC10@DM5PR13MB1467.namprd13.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3002001)(3231220)(11241501184)(944501161)(52105095)(93006095)(93004095)(10201501046)(6055026)(6041288)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR13MB1467;BCL:0;PCL:0;RULEID:;SRVR:DM5PR13MB1467;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR13MB1467;4:eyJGBaW/wxOIn5lbZ0Aeg+InuEI0miAYOjWKta/FOV+nWzD3c6hAFBsRiNB+qGx3INjTMVGg9vGqOGDO+EtcO17HzT/xgPj2XdlVsRzDHDyOqRebiVbHNRchqpuTtIv8hVpIDJBY99vWiZRkVkfYRZm2CNMtSWU8W/O3xUN4tgqTL93j821PqOFY4ACdsxDQQPCNifgrxzSR5Yl7NG7aliL/316NF0MVD/edwI8kjF2CGeW5uW36kocjNsqMM8v9FBUNwDrdA2UwanUMAqTALQ==
X-Forefront-PRVS: 05954A7C45
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR13MB1467;23:+I/hqO+hC5NLJGNEyt8rD619+PW/NkxYSiV65gvOT?=
 =?us-ascii?Q?f81O9X/8gnHkwuIgpVOc8M8UjuczLpDByVqQV7vFDKGMA1tIYum9emG6aVmS?=
 =?us-ascii?Q?Kke7LtKrXUtYnzHhwKVR+9Qc5rf+OOMGezhZzJFJk3dRSgwuuPwJvAZxpNRQ?=
 =?us-ascii?Q?w1BLLyaxYOfah9QNGa1pdisBGk2oCMmWrgbX7HQdLhQasCjTrZw/MdxMCY2I?=
 =?us-ascii?Q?0lPbpVF0Q0Jr+eZZdvpWrBBeUfrrdb9qwvYQVY0/A53obvpoDq9zAz5UH8Ds?=
 =?us-ascii?Q?X1uxEq6pYCcoiM096swIh5zGcx1IU32ymWCFQlrNIk8J8qDOwsorZQM4yS8w?=
 =?us-ascii?Q?uWbPUKI9G1lzw4CaDC5Dny+Z8HdfY3bxqxfK2a6O9UArNms6+V7DELxrHHTl?=
 =?us-ascii?Q?8lvwoHuNIhjKL/hqtpzuCbg/qL9YqCpg6rcHUfRyAriLR6pHzbHYV+4qGprl?=
 =?us-ascii?Q?POTnaiYKuvJJDeQDizrnyzd5t3kE8hK9WHgGxQWSW42GQu7UHjSqNoISOoHA?=
 =?us-ascii?Q?jgt4B76PgUcEwBN+93QgJLyAqEaQvJMThZikIcolIL0d9FhABHZTV+pdnWRq?=
 =?us-ascii?Q?yTeS0riFbwslfRXgSExb5bqAxctRNub0o5tA6zFGjHpmgS60fggQ5G3JZB/D?=
 =?us-ascii?Q?PMb9JPAEWV3WRcXbeKJZ3yO8HBFlZQk0QlYPSi/pUxsXM7Us5vqjBExsga61?=
 =?us-ascii?Q?ILbavarVpTC1zpcVZwMW2TB5xH78LbaobVbZxvS7g8Q+20RumdTPOGGXSShB?=
 =?us-ascii?Q?sPnK+JGdlfXFwyIIZJZatPi/6riEP/J7BMUiBGntnvbpZ949qLC+M4lBKHY2?=
 =?us-ascii?Q?mMaPC1UuXeeNa30KulFPhm424+RbuK6kYkzU+U1RY8V8Df3Z9HuNw/zBPVEH?=
 =?us-ascii?Q?c+EUf8W+NCIkT8J/JnrZiV0QzHztVhYdVimtnmsQAoRtbpDOot/lhdjY4MZ8?=
 =?us-ascii?Q?bp+eZCYNOeLWfk/EeaQcaJ2Nb4j2NQqaYknPyPHVL7unLdc1ZwqB8YBSR8h+?=
 =?us-ascii?Q?zGrPfTUWRDbqMHbs7Oaf9AY/+dzqrz/BrW5x9HTUKaEDFAglXpMNuL1bFiGu?=
 =?us-ascii?Q?FlNd+52xeEw1kHZufywE4px1MLdsvCPA6owWSA+hKxsDXtZaKlwNEABP845v?=
 =?us-ascii?Q?9oJl1Wi+XCj+CS7tqCxggk5VqxxEMgdVDCBb37ndIzxXFKaKmvIPBGS1OfDL?=
 =?us-ascii?Q?QDImcbQgPanv7v8hn5o21mT2kKTcAxaojRgIwmNglUP6FQeMYDWSv6QbMqtq?=
 =?us-ascii?Q?xwJotwuyypQEIj+LBs=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR13MB1467;6:OGq1b7ofZYqcikVpjRWgIGFVl4BEhFruOzhEhkMZdrnnQOLxKhGuxMTTrJC1gJ3CIacPrVek/cnQr+oGMJs6DtkEOV9UoeRtongFgVKRe8pcdQJB7kpV5fjku7Ivd8BVbTUyrb6wxK32lJbUcfQf7zzU/lgKTEp0gp4OxIo3MkPk/zFqoT2j0lNo6xRiyIQSsqS0Nc/5GxsnkmxdOfTa/xd+eeBSIZHkf+kaOvhddAZGTidcrkFda/jMfglGG5lKveCuknEZM8ElmKXBRttFsx0Kp87YI2ochQedq3ua2H1iAdHPJ5IszzrPFySYAurbe4gm4ALK3us/JLcyjRwhhezZMlMnyFC4cI/Gj+cwTI4=;5:AsE2iG4e6mPog+3PGe97HrBgbfAqMsDIun8+zsCYLd+F2US76rWpw5oEwtRnbVFHrv20ws88oAK/8tjDXuwdiQyi582ZbvmM4eqtICLgLOs4BB89YjZfjSTv+yvD84fppN6YRjkQMoDvthJwG9ksvm1Vc09eHoRRuCcAqre6qqQ=;24:ENE8yKJd/Cn9pOcsj6QVhXg2uITUe8LuH+HQK/60sdvIL4SSajnc0GuWVmToQhyZICvpVEqrwn505v8Mk9jZnilY49yYYBXS3GasgNYywr8=;7:w4bMDde7q9ALKWEJ+n3aZ5ecQIpJys5VacU5FLr8+HYKXCINoQUOeyQMkRBNBARC0h9fJkaoV3T2zB8TZOdTV50R88ZgGb9qVCC/Uf7p7URwvxwu/RIvAUNaMLp+5zC+fTU+EXWnT6YAIvc7FXKfhaKSfvCXVzUJsckRyFFCclrJePi+SP89nvKcrSFWHaBs2ANoLyqSXSql8u9A5Iyv96VSxJsrKifRopy6i5w+k6m5y/jLF/otv37ZGIQ4cxJ6
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2018 00:49:43.8893
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dfedbe9-1948-469e-69c0-08d57cb2d3e1
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[117.103.190.42];Helo=[jp.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1467
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all

I sent the patch series of Sony CXD2880 DVB-T2/T tuner + demodulator driver version 5 on 18th/Jan.
I'd like to get better understanding of current review status for our drivers.

Are there any comments, advices and review results for them?

Thanks,
Takiguchi
