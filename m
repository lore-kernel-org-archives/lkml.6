Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753317AbeDMH2E (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 03:28:04 -0400
Received: from mail-he1eur01on0090.outbound.protection.outlook.com ([104.47.0.90]:12832
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750911AbeDMH2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 03:28:02 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH linux dev-4.16 v2] i2c: muxes: pca9641: new driver
To: =?UTF-8?B?Q2hlbktlbllZIOmZs+awuOeHnyBUQU8=?=
        <chen.kenyy@inventec.com>
Cc: linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Wolfram Sang <wsa@the-dreams.de>, Joel Stanley <joel@jms.id.au>,
        linux-i2c@vger.kernel.org
References: <20180320061909.5775-1-chen.kenyy@inventec.com>
 <20180320093200.19179-1-peda@axentia.se>
 <5053d0d0-e4c5-733e-051d-b5900d05ea2b@axentia.se>
 <CADo_Z40fZaT8iRSALDv7-YaK0YD-WFph5RwmrngFbC4FzFAp9Q@mail.gmail.com>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <3dc71810-a743-9fe0-c8b0-7e42d8167685@axentia.se>
Date: Fri, 13 Apr 2018 09:27:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CADo_Z40fZaT8iRSALDv7-YaK0YD-WFph5RwmrngFbC4FzFAp9Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: DB3PR0202CA0025.eurprd02.prod.outlook.com
 (2603:10a6:8:1::38) To VI1PR0202MB2781.eurprd02.prod.outlook.com
 (2603:10a6:800:da::19)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2781;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2781;3:34N+RdRCC+zRN0FLLQ0EOdvHPaSv1Dky6E7ne0HESO9+JDvqKWPAGvBA4osocmw5fdZSfG4uXrXHwE5vecC3vF1k63gFyaVlLDgVuC0UGA6ji7EXQUFAkjJ3a567CKqvf1VvDYcpYcuM+n97IYBNAIRxN2//4zAqM61+PJyUtbQb/R51KSMujk4mx9hZRhbXcQArlSlRtoFwTeiTtIGl/F2yJSvcl0DEXkAMrcuijE5DD92dCj4Xz5S/VlANdyu0;25:N2vVynnlU2F7PMctq7IhsRUa95e6TSxb0nxUMDrDEC0YYMJ//pm3waUWUMb2O20HRTyYoiG3KTkyd5QWYdPZsBgPNuJohlgf2oMXSRCOyhKGIVE6uvBggX4Y86aBkxtdmWrCJcZEV7xnFXgkictDoBm0hAhfvWiw0M9AKtkCzogl9kwr91eBmqgiwirx5TnNoITFPMKU5qC+UtPRgfXhA+UZ4bvPEoBlkew4gPwShn/1isy0J6vIU5veDIwH5eOes9OX4reJ+2k/+QMy7ElJFuc70VQT237/ZnT04mJSVqUr8WthVR6+rol8y6MbQEcJ0GBGlp7tqiTPYkm6pHTGLQ==;31:eRc/XPIW5vpjKWJv0g9/GhnAwFhqsZYy31OViQKZoILGHkbAmFT2hj4dBIUcBi94Bc75kE2isro7ezHh7VWGRtI+t78B6jRgkRA2ZWUJUQcfRzgD8kfIXRcOln5OUZq2JnzQbakvzfQGiYqqbEzaDoo8NMdzPXamj7vx4IO1pxO27n6YoMoU0Tmr2TdluH8MZKAQlD4YrR6nUtWxFRtCwEsxusISWZ9iAmFhmGPPlcg=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2781:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2781034FD18C1843427F8A2BBCB30@VI1PR0202MB2781.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231232)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123564045)(20161123562045)(20161123560045)(2016111802025)(20161123558120)(6072148)(6043046)(201708071742011);SRVR:VI1PR0202MB2781;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2781;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2781;4:U7dpz8hr6pad79GQdDT0ZAMp1MZgrwdufty1g5PeatXUlRta1UhVQRan4dg6RgOlYsf8vpjfq72RkOGSlg7L32ifdAOlqRXjX4heewMcXsjqVT1p0xeFrWHHhSp/nMn+4zdqastDAmphao28Yt2T+2hfyDoY+Idvl5TySkWm89gX8pZkf2Nc5m8MFiuIospe0wbanzBinuJO5eUZEPMT4DozwXKHtzcd2hXdF61V6WcITYGf+PyzL/7KQQ/UZfUPfUeOaL0g6rjqEs7vZp/c8Q==
X-Forefront-PRVS: 0641678E68
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39830400003)(346002)(39380400002)(366004)(376002)(396003)(52314003)(377424004)(189003)(199004)(11346002)(956004)(25786009)(2616005)(3260700006)(53546011)(117156002)(6116002)(446003)(97736004)(3846002)(229853002)(76176011)(386003)(31686004)(36916002)(52146003)(52116002)(59450400001)(106356001)(6916009)(23676004)(50466002)(5660300001)(105586002)(2486003)(8936002)(68736007)(6486002)(36756003)(93886005)(478600001)(186003)(26005)(77096007)(31696002)(2870700001)(86362001)(305945005)(64126003)(316002)(53936002)(16526019)(65826007)(6246003)(81156014)(486006)(58126008)(54906003)(8676002)(7736002)(47776003)(65806001)(4326008)(476003)(2906002)(81166006)(66066001)(65956001)(16576012)(74482002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2781;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAyMDJNQjI3ODE7MjM6am45aFhXR3Y3QmZXZjlsc1N2a1lTZ3pV?=
 =?utf-8?B?MkcwanBqa3pnTXdna1hZd2hlMlZyVWFHdHJZUThKbXVxZUZyYVVZRm5rMFo5?=
 =?utf-8?B?MlZhMTc5QjQvcTBEeS9pUFZIN0hiMEtnZnJRV2pmUDlacFRsbXBDZmpvZUlo?=
 =?utf-8?B?YW5RSEdrc09WcXNORlUzMlVmL1JrcHc2cmNoUTJsanlKSm94bXlORlgwWllE?=
 =?utf-8?B?dEFuSDRBaVRBci95RkxMOG5rNHNBdmFKb2x1aElYcXVVU0lsR3NBQVJuaER4?=
 =?utf-8?B?WEdwSGIwRkdHOG5IaGVrSjJWeWU5WjQ2OVJtMk4rSncxSlE4cWJFZXMxSjE2?=
 =?utf-8?B?SzlQaTdxdlJnZHQzNGV3aGVTS3hHK1pvZkYydjhjWlNlemd4bENWV01WTGtN?=
 =?utf-8?B?TFNNbkMyQzM1ZEpwUVV6YzdaTURWWjBaOXRiN3hMeWhlYmUydDc4RHpWb3lF?=
 =?utf-8?B?dG84RDdsL3pIYi9CQ0Fzb1Q4MWJ2UjFSMnpJQjlqcy9LMnhhZWpKRmlnYU4y?=
 =?utf-8?B?THBrU3BkQUZrWS9pY29IOGNieWp0N0JRQjRXejlGYXBNMElvQ05qcjRadEhy?=
 =?utf-8?B?cjlibFpYQ1c3cXpGQlZmWjZvb096M2l2Z0l6Q0R4VVJySWw2bTZEQUF2MG43?=
 =?utf-8?B?cmpaU2xxMUNqSk5zaTlTdlFCT2hZb1RoR29CdmRMVzB5SVlnZjByNmpZV1FJ?=
 =?utf-8?B?N2Z1WXczWVUxcUZ4Y1lGV21hMlZBZExmTGQ5WlB4aGZRZytWU0J1YXVKelQv?=
 =?utf-8?B?dGZyNFNKY2x1cUM3VnpqU21tOGdhSldFVVJqUG5MUHZBVWxxandPZlhJOEla?=
 =?utf-8?B?UHloWGY4NEJSTnZtZUh4cFdERFcxeFJmNjA0K2J5bkI0bHh2enVHWjlkWEo5?=
 =?utf-8?B?UDBwakFLdlMwSnVuWG85U01tSHNZVnZPRzVzdnFVMytMNTdHb1pTTG5lY1hR?=
 =?utf-8?B?ZHFPU2oyZytlMndZckN3RTg0eTRoTTU5M2hWMHgrT2RCc0F4TkFVcjNFcGFL?=
 =?utf-8?B?ZytNQzJhMGJ5a3Frd2FXaytCNndVYkZ1dGFrdTkrYmNGOGppam5oVVRucXN1?=
 =?utf-8?B?MytZd2w3Mks5ci90SDFVNXNlNXdEU00vcmN6dTh3ZjE2Z3l5YVBoMk9XbVdL?=
 =?utf-8?B?OEU5M1l0THk5cTNWczZMQ0U2cURCM1BXek9XNXRtQVIvSlRwVERSTjVLZ1BF?=
 =?utf-8?B?aFh3L2dCY2N2VFI2aU0wMlZWMFFCbE9iUUlnci8xMEE4NEV0WkJWKzYwOVZY?=
 =?utf-8?B?bm42a2ZQVnU2aDc2WERHSkFzc1NaQWIwNTRCYzZuZXNLU293emdldUFOaE81?=
 =?utf-8?B?bjIzd0NKQmg2TDF3THBMR0JJYlVhb2VqQ1U3UGQzQ2plREpMd0t4TDVrMmRM?=
 =?utf-8?B?YXE3U0ZmY0FGajkxSnVCVTBEcWxSVjRCOHpGbUphRk92SW5ZcFhSYUpLUkNP?=
 =?utf-8?B?QVA5VytVV2tFSEFtR2dIOVVoMVNRdDd6MmljcU1Obk9zMk4ySU1UVHNSWTVS?=
 =?utf-8?B?aEtwOWhNOHU5TGlPZDlpbFJWVmwwK09HeEt1RzRHdlZteithcVo0RnQ0QW5Y?=
 =?utf-8?B?dm9QNXdUS2djY0V6RnRRZE1sajJKcUowRlhlSzlkNERNcDhhSnRrdTdUV2lT?=
 =?utf-8?B?TkxkcDFqYk16dm9rSUpwS3d6Y29RSkxpT1VoOGhaaWlyTHdZWFJ0K1ZNRmQv?=
 =?utf-8?B?ZDdtQmpSKzB0UjZPbWN1TG1na3NqWGs4ZUx2VUcwbjBRRWZIRkRxdmFaaWFz?=
 =?utf-8?B?aS8yM2oybUROS2l1OXhJV2VwUmtybUVNYWFVWWQ3VFE3K0dPVFdZaGpHSzJn?=
 =?utf-8?B?djk4aDM0eUFSUmtqQTV2K0tYOVd1SFoxU0hDWWhHL09lMDRKdm9pVnRlWXJV?=
 =?utf-8?B?SlZqNWg3bGpjczZaMkxwUXd2dm5vNDJvVnZTNithbXUxRzZwcm5qWFoycjlk?=
 =?utf-8?B?U01hWmtucEc4VlRueG0vZjR2ajZUZDB5REVjLzZ6MXNIK1A1SDFESFdDdU5y?=
 =?utf-8?B?WGhyaGcrUHlUV3lNU1I1WjVKL2F5T0h5WHNtc2xOQkgzbGoxcUZMZWgwR3ZZ?=
 =?utf-8?B?cjdRRWZuajc0QnVZQmkzNjU2NVhMd3g2UUFNSk1LamJhZ2pNbFFHMFFRcFpl?=
 =?utf-8?B?Sk9tVnJ6UjJ6akR0MkgxSnFQbDZzZ1Y3QTZEMWdLTWdlWkxUZXl1VGs0S2l1?=
 =?utf-8?B?T2phZ3ZTeENTUGFLVTBub0JKQkZ0Znc9PQ==?=
X-Microsoft-Antispam-Message-Info: Df85fX6w0gdtZJiFwGI1DMuCEte+qQayAQNVWcSi4KjWNXe03tPYS6+xedvyyU+WsuOBlw8M7PVPQEITYY0Pua1MXM2PH1BK4fSqVOrLAnebnR991S7I9hF4EypvMFwcFrOKNUqHflOz+aqV8z1SpgnMueqJhrsf23eBG9l2N4KDtu6hJYwdIlhAOv01e9zL
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2781;6:OYk6fBszbHYrhmu4WrLYFOlpwC8uG+6eFc3u1c0mZ9fj7o/TF8dddl4hr/OSRZined+7otPQYsYLfMJs6l0vU9FU7q6hucgaRfRpNakViAOxE9iKApgH3+Cb/58F4XZr6xu17R9SFTVT8cOwQGk+TgOjrAxmw3oGId/e9EwSUOg+V1yhdqizgmbcm8/LdJP0+WCOz+GVgutoXK2A4rT4a4cINU2bFo/3Rd+ilR0qhaEem/QwkHPnEKn3OLx7YC8apA7G2Ub8qPes1Pbrg1kDNUIgR++zBqfZXCMMwwwIBLLPbI6bFEQzgIPpHQHW+HVFpk5Abn19D1ATsYFEObgdLooKw3E6UQqz3KUGrTx5ohwAlA4cbnrEO8Kkkso3vUSIgWqQYd5KvEnZP/y/5RSPts9uXmFkrpWFsRpyFKwHaJExTgr+6+Au4UKGfmtMEu3jDri1461jyfUP963tCFXyVw==;5:6Aw47h6K68mmwg9ZFcI5j0EpZs74G48yS9ihGuH2/JeJaAeBZtWveLSstVrIOBlmfAR03ShLxL3frV4FQmOOBpmhz5XvZOKiRMW/8SYGFaEsevBTBINqqxRre2klKVnMr24eeWj2hzUsYjYzHiAJQn5GpP6GWeu3MDNW9packDA=;24:4gqdoE4sFsAHeXjV8+vjoqDJxe4zzlxUC5xm0yd8nItjt8y98pO4hDld/cSUcSF5hoj19Ra/RlOdmdeuhzYQOBeZ9DuAYX7rC8dvbBLiTuI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2781;7:dS52YQVfbUDCmn9hJsLK+2LDbrRUO6u4y4I5eWvKYcyE7O5e80MivyQZ3MEX5BfaM+Y66FIRzdfZJoFrFP8flBFBANeqxj3TERNFTg87+jyKtkms9rtgFpzFL5zpJUpWxhwSAbrynHxHPlPMOGq7VyqAEFbxRB3QDPjP4pqByCho6yPII9nz516GJB9RDoA3+y3WtpaW3C6lQRNanbhrfj3mhXVLKgt9ktJhOao0rie2LI8PBLBvfO4tMoVCNuib
X-MS-Office365-Filtering-Correlation-Id: 5c733d49-ea86-4d99-fbb0-08d5a110122e
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2018 07:27:53.2692 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c733d49-ea86-4d99-fbb0-08d5a110122e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2781
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-13 08:59, ChenKenYY 陳永營 TAO wrote:
> Hi Peter,
> 
> Sorry for late. Here has some event at my company which needs to pause
> this work.
> 
> If the status changed, I will update my patch.

No worries, I just want to know how to handle my preparatory patches. If
nothing changes, I think I'll push the first two anyway, but will hold
off the third until there is some real need from it.

Or can you perhaps make time to test a patch adding pca9641 if I adapt
your code to my 3/3 patch? Then I can put these patches behind me.

Cheers,
Peter
