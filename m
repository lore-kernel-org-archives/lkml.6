Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751686AbeCUFnr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 01:43:47 -0400
Received: from mail-sn1nam01on0051.outbound.protection.outlook.com ([104.47.32.51]:33024
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751396AbeCUFnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 01:43:42 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Vijendar.Mukunda@amd.com;
Subject: Re: linux-next: build failure after merge of the sound-asoc tree
To: Mark Brown <broonie@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
References: <20180321133040.6754c372@canb.auug.org.au>
 <20180321024556.GX2186@sirena.org.uk>
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Message-ID: <3bc6e9ca-b1d9-3458-6399-758be07fd7f3@amd.com>
Date: Wed, 21 Mar 2018 11:15:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180321024556.GX2186@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [125.21.194.1]
X-ClientProxiedBy: BMXPR01CA0012.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::22) To MWHPR12MB1678.namprd12.prod.outlook.com
 (2603:10b6:301:11::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9d4c63c0-0444-43da-4212-08d58eeeb2f5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:MWHPR12MB1678;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1678;3:aE7ck7PDxuuxcag8xKiBrQ44nO6vBi7hNWW1xW+LN816ovVuFokNRX+6VzgDZsXofz/446nkBbp4Q/rnhZJs/3gc7L3u5VUf/sCiwG0kbID7Wu2/GZOuTqyygnHo50p0h3v+3BeiAc2HqWNgLUmEbqY7sqXafoVTOTM0kcQ0OjQcBaXIVpOrsUnhui7bT2NfCRponYoJhkg8XR984bF/hWb7i3P+U2pgdVIysD/fQw09Dxzj5F2X3gmR4qGfWXjA;25:A8odtxyhSb4sKEg9agAcVsIoFBec135xs+DepVOM58Bp4mSF45xauL7kf0b4XiaZt9HZXf5O7loMFqA0RAMiK3l7HzSaq38AEp7xNJ7r9dZvS0/hvyjRDMA23oCcQZ//XFexa4Yf1R7MY9HwI+ABxhtWuvFaUdgKSf223/GKAuxSvqU5udAs1Oy7ent/dv7bxz6peITboCJ6UriqAQGZk9vu2nQHeJY8dMRndE47LOX89W5j+J6iIP5mAQGH9wk52cQPKNoT5htGjV03r3thDbIzPL8WolorL+nMF1vshDWaLqbkC8Gx/fJC9KFW9qCsk8EislfwupRP8ujVjXwKCw==;31:aODjCHSi6nSbzYMERUfcOOTDEG8jt7p1Dfe9CQ2SKcJfzkqzInZeJIaYH3tjfwT7xELI1wS1ofjO28OeWalLPTbzD9/kFHmHGDrGslDGXdwP8CK8jY2qmquuMzjXDGFIm7kt0uwyjWXjhOGwL5/bhlLnXDgIisTXFrcfEQjiI1WAqP9b7k+rY8APfnPBMODf/9Ucame4fgw3t0EWWjca9Qdy2b0PGm9cAvRleQq+oSs=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1678:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1678;20:y3cfI9KvDfmo4K6vJbfh6uUE/6BCGQ+5J+ALDDnJIQ4YvqdGjCSESfWMbPIL81le33aFRviDRRDXvyFFxfugeVUPgR4Y/IFII40sUT47RpKfyLvGJcnAJjnizRZRbTLgTurVpP+eFWKzaanNHa6+1sHPKD6l0UIVShv3X1RJJ/sUX5RtBjhkjQWmOpvII4GmpG9LDCHa5n/aSwKfrzDb9cs5s9d/aR5aFYfaT8wYtdlnlIunnj5t5QZKziAkQB+PWi8Sh6S91HdzDq0oF4/m2qZvtsyICC+0ZHdM+S7IyGYsukuNKsfL9FKf7Bs6Vqn1khp/48bN5g0GBdbMhfKyvu20Hm8bp8u0bc6saFJewYAZeFi4EHv31OJcdlv1mOyV3Rjyr+fegI5tAVJlTD5rQDjJpSzwVhCkO5ASK5hn9Ibj9vZLWD+EGduZKgWKKSpEeqojwIiY6l4H5Gd5YMWUkXLfMCwRf0J2okyCZQW7oUICkhJcRb/7yDX81VBhn6Ys;4:6DnK2gyOR9u/ATuQyWaEoU4aoSGAElnanGjnSNb+PDoeQTdiEHElnKJAkRMKA4RvTSOQUc73KWgojqnX09jlarq/9DTygxoBWY7z8LFhlyJVhbTrqHCdoZuqGYsMrKd5dGm1Mwnqh9yesvcN90zbzh54sbIgqcx6aApH8IR8RlIE1quuDyMt+01l0jiEizSY555vqRk7r0EZrY8/CNBmZ+iE7XQZhSwjscgbtQgPGJF+chsGCw3wC5Xs1rvi6aEJ+jaUrLRjEY/Akp1amSwf0Q==
X-Microsoft-Antispam-PRVS: <MWHPR12MB167819FF821C65BDFEA1275397AA0@MWHPR12MB1678.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501244)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR12MB1678;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1678;
X-Forefront-PRVS: 0618E4E7E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(366004)(346002)(396003)(376002)(39380400002)(199004)(189003)(77096007)(478600001)(31686004)(25786009)(76176011)(5660300001)(52116002)(16526019)(72206003)(6246003)(386003)(67846002)(53936002)(31696002)(64126003)(316002)(86362001)(47776003)(6486002)(3846002)(305945005)(6116002)(2906002)(6666003)(50466002)(97736004)(7736002)(65956001)(65806001)(66066001)(16576012)(65826007)(81166006)(81156014)(4326008)(26005)(58126008)(68736007)(105586002)(36756003)(23746002)(106356001)(54906003)(230700001)(110136005)(39060400002)(2950100002)(8676002)(229853002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1678;H:[10.129.12.246];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;MWHPR12MB1678;23:nNKp6jN8uZiKIjwEv/5O9RkVvu/Zyo8ZZZfmg?=
 =?Windows-1252?Q?+btxiIqPGU88ppG+6seeGh4KzP98tB+2EPawA6HlODe60uYbxZYCUCUG?=
 =?Windows-1252?Q?d2LXL+tNvSelsZEXyz3Gq75NDozDCEnQetEZShzasXy4d/adbIBWHAI8?=
 =?Windows-1252?Q?oHGMz9yLBJHxCeOJ1kS/DBUaHAvCyBn2oQCpW07HE8ptXvAH58PkFsTv?=
 =?Windows-1252?Q?5+L0bbDEdKpa9HY1+haBjh1htHKFiEPwkSueoxHXUY3JzfHpIdNdJE8b?=
 =?Windows-1252?Q?VkokXUlmC+az3Dk9yZXS7LnjZ0eYkTG6Yy3dA4qIrO6b+ls5m3itkMA9?=
 =?Windows-1252?Q?3rU08iL/dK12BPWOw//t8hFcUuxM/m46kMMT1CcsTzerT84kNX09YjfJ?=
 =?Windows-1252?Q?Ewy6/MuCm/jb3HW4UzhlnL+kSDC+ChWdLtFAAFUINVfTx/Tp4egQFP8e?=
 =?Windows-1252?Q?FULocDNhNsrWd1LnfmtPcB8/MD09KoqOdDaVAxqfWhV6HtAjbuz1KYtL?=
 =?Windows-1252?Q?LwpWEmqkZ/uiPsETygBXlUs6Gvhh5QxomBL+XTWFWqkRcsj20/uPN8Su?=
 =?Windows-1252?Q?Ezjc7RSCN5T4f7yX/unmvYMfLsHs8Ov1isMxhm2eiJfa3aME/MLy/tW6?=
 =?Windows-1252?Q?Po3matyOpp6KKzMnoiCktE44+GMmHqZVff26n3iF0CmQDbmAPrL1QunN?=
 =?Windows-1252?Q?6Ub9e1E/E+eInoQH+H2Y5RVRzGqT7dQ8CWLuVdy2XguBF87adn3avRuV?=
 =?Windows-1252?Q?eOjY2XiiEbLJG4dvb0WmqPe4CooJJ900scTQQOl2kx67F3Ja5YFjkuom?=
 =?Windows-1252?Q?r7nb2+P3EIdLhorw8LhLK9XrwrWLzbbvSKsQp0uW5gCwgxL6jQEL7F21?=
 =?Windows-1252?Q?6PLKXFCYH7eyasW2BjJYB9xgh+0gdoMXtvMJfEoZZoxkJ+wZ/4v2HM1R?=
 =?Windows-1252?Q?WBo4rx0aWjWEUZtR9lsL6dkhU/+jlu8s/AKEMhYClsrpXAHrWSLsLmPo?=
 =?Windows-1252?Q?ZbodXCQV5oSzFFqYSi30nCRqG7BT3AKNQBnESqKUjGY1+ID5GYK0i669?=
 =?Windows-1252?Q?sdogwZlSvKnswveh/HZV310A9iIEYtZxCOpds9h8AFxZUb8OtdOSUPR9?=
 =?Windows-1252?Q?30aDks+WQQ7kzGZYzwYIOcsqp7OZw27Wn1ccM02YxPmkFErfmIp9MEpf?=
 =?Windows-1252?Q?zz29nxd/Uc0aHoDRfroFebAtDTnruA+gid+snzIabHCFKGegVI+DVeOk?=
 =?Windows-1252?Q?BdSM9MRia/U7l+vNuaT7N0yRhA8h8/qPPuMurQfRpJ6tn+4kZKDTT0lw?=
 =?Windows-1252?Q?BX1Xty7NoWBZzksXKv4wTQTL7DIxzqvwS3EktK54OVyBCEC3soqAQP0D?=
 =?Windows-1252?Q?kflrmFiQp0Nf7lOtCd3V/7XlN2WbebB46M2sfgaCtLiRc3pikquXNBHH?=
 =?Windows-1252?Q?p7cHTXVUOpX4FjidlZwZAAJCRjWHf9H62dQKLmsdA=3D=3D?=
X-Microsoft-Antispam-Message-Info: PdB7OOsbK2Wgcm/NBHB/OXiX1VwAo5Imt2bi4zbgm31m4WFSMf8b96mOU7QsQapePeJGnsvg4WQyVYo8dZ0rzGibZlx6YhTeZ7FALdsMlDzgEkK3KAJSvajmtkTYMC1ZbgZYRe5FCdHuz1AJWFIUgPwQClfynVqIZh7OAxirw5WzMnAJDg5S6D/PGSRaw57f
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1678;6:Luij/o7NPrz+Qej8j7Jy+ffYc3asz0qP/JmkGm8nAPqodNHVvhCEeMUWsoCQ3f3FlkQdBCle7QLZCMNkUARo5Iqn90VLqfegT/HxxFHhwxCwzrK40eq0R0SSva3ITDYuRbt2Qn0ZXL77JDHQuO4S6Cz6Gh5XAt0gu3jOGQ/LmOgkRAtck2wBlNCyF0YOE0D33I1SH98RTwvEupPiYsbkH45c+SZG935i28Qm0XjUZ0fsqXenP5HoCYi22AicQze9m+WJd4jYTTK7Ey6vmArBOJ/17VlEO7tcy9Xeje45VjFoQbacjsdaXNiM4tljMdKa+Y15s12Gf5xJerY8v4p3PwHuHrYGIWptwAv5e5LchIs=;5:tVfMKbrPXuy+toL0NVv2BV9S3HxjUQJsL4xehx9uQKKd5j1SU0/r+qkWc7P2tCL1BG8lgSqYkssy/oU/xdb1m2h2FWtuH1ISPCLbbuZwukc6Rb7sGG5+8sZI5DVoysV17qd3nwc4X+jv7FLtdYl5/QD/IkmvZMndq9m4mn4D5Xw=;24:dKdpSPYejAFQAq+xOwoWaQ8WfgidDJFqEYsunKleYwgLxshMZo972lxArfR0DYOVuUMzpvHarCD9PjTtFlc0d33uSW/6gH8mnWDGiHMvOqk=;7:KpsorU7ne+AQmjqaNb8s9S1UOQT1nxVwmhR549GnpgOuOi1W7YXwvDspZMM2vqDoP8Xk6oXZhTZ1IjpsGnsIjLh6SeD5pulEaDYrX5dXGgoWrk6QOtCVAuuoMdqbMfsl6AQvkoe+l00LghYK19xg1S1iJke2fcFzmI+rkAAYH2MIfSV1q671i+a570XlqOq4W7JtmR/G5OI+SyiNaTK0YE5FmIfGnoe4gsjWPhvP2dcEGjE0/ZDSMxi4JkCAwIe/
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1678;20:SMKSUVcbdHhfBm2SJOHscjJePbERfjNiSzKZHpn2oKEMRsfj9+LzFPf9gAZsgdar/dZcC2XuJ+H517Rw/NEmX2ishPcSWNJAzQXo+EzhYLalcGqgnkux95ytWwt3JNNmxBWs1dtnyPhiNMtrxdTd+w8ig0cyCkDbw0L2J576arGOqzX4B7q2LVUgPznyOzZkLv8hl2upgcwC2gDc63P40b2t9aTxBIOJv1yAZ8vVayLrd4dG75VVqHbTvu27+mzD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2018 05:43:36.8574 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d4c63c0-0444-43da-4212-08d58eeeb2f5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1678
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday 21 March 2018 08:15 AM, Mark Brown wrote:
> On Wed, Mar 21, 2018 at 01:30:40PM +1100, Stephen Rothwell wrote:
>
>> Caused by commit
>>    363fe37948e2 ("ASoC: amd: dma driver changes for BT I2S controller instance")
>> I have used the sound-asoc tree from next-20180320 for today.
> Dropped.


There is a patch dependency .
Below patch not merged yet. We submitted for upstream review.
[PATCH V2] ASoC: dwc: I2S Controller instance param added
